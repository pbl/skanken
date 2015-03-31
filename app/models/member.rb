class Member < ActiveRecord::Base
	def self.search(search)
	  where("name like ?", "%#{search}%")
	end
end
