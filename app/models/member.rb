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
		@member = @cooperative.members.new(:name=> row[1],:mobile=>row[4], :email=>row[7], :personId=>row[3], :activities=>row[5] )
		@member.save

		end
	end
end
