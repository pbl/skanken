class Member < ActiveRecord::Base
	has_many :contacteds, dependent: :destroy
	has_many :jobs

	def self.search(search)
	  where("name like ?", "%#{search}%")
	end
end
