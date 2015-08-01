require 'csv'
class Member < ActiveRecord::Base
  has_many :contacteds, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :activities, through: :member_activities
  belongs_to :cooperative

  validates_presence_of :name, :mobile

  def self.import(file, cooperative_id)
    workerList = CSV.read(file.path, headers: true)
    @cooperative = Cooperative.find(cooperative_id)
    workerList.each do |row|
      @member = @cooperative.members.new(:dateAdded => row['x'].to_s, :name => (row['Namn'].to_s + " " + row['Efternamn'].to_s), :mobile => validate_number(row['Telefonnummer']), :email => row['Email'].to_s, :personId => row['Personnummer'].to_s, :activities => row['Vill Jobba'].to_s)
      @member.save
      begin
        @contacted = @member.contacteds.new(:date => Date.parse(row['Senast kontaktad'].to_s), :activity => 'Unknown', :comment => row['Kommentarer'].to_s)
        @contacted.save
      rescue
      end
    end
  end

  private
  def self.validate_number(number)
    @number=number.to_s.strip.delete("-")
    begin
      @number=@number.strip
      @number.prepend("0") if @number.start_with?("7")
      @number=@number.sub("+46", "0") if @number.start_with?("+46")
      @number=@number.insert(3, "-")
    rescue
    end
    return @number
  end

end
