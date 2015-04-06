class Member < ActiveRecord::Base
	has_many :contacteds, dependent: :destroy
	has_many :jobs, dependent: :destroy

	def self.search(search)
	  where("name like ?", "%#{search}%")
	end
end
