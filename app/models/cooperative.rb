class Cooperative < ActiveRecord::Base
	has_many :users
	has_many :members

	validates_presence_of :name

	def name_cooperative
	end

end
