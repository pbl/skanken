class Member < ActiveRecord::Base

	def self.search(search)
	  # search_condition = "%" + search + "%"
	  # find(:all, :conditions => ['name LIKE ? OR email LIKE ?', search_condition, search_condition])
	  # find(:all)
	  # find(7,9)
	   
	  where("name like ?", "%#{search}%")
	  # where(params(:member))
	end
end
