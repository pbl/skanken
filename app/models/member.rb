require 'csv'
class Member < ActiveRecord::Base
	has_many :contacteds, dependent: :destroy
	has_many :jobs, dependent: :destroy
	belongs_to :cooperative

	validates_presence_of :name, :mobile, :email, :personId, :activities


	ACTIVITES = {
    svartklubben: "Svartklubben",
    heartland:    "Heartland",
    foxen: 				"Foxen",
  }

  def self.activities
  	activites_map = Member::ACTIVITES
    activites_map.to_a.map! { |arr| [arr.first.to_s.humanize, arr.last] }
  end



	def self.import(file, cooperative_id)
		workerList = CSV.read(file.path, headers:true) 
		workerList.each do |row|
			
		@cooperative = Cooperative.find(cooperative_id)
		@member = @cooperative.members.new(:dateAdded=>row['x'].to_s, :name=> (row['Namn'].to_s + " " + row['Efternamn'].to_s) ,:mobile=>row['Telefonnummer'].to_s, :email=>row['Email'].to_s, :personId=>row['Personnummer'].to_s, :activities=>row['Vill Jobba'].to_s)
		@member.save

		end
	end
end
