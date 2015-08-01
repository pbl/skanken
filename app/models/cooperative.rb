class Cooperative < ActiveRecord::Base
  # has_many :jobs, through: :members
  # has_many :contacteds, through: :members
  has_many :users
  has_many :members
  has_many :activities

  validates_presence_of :name

  def self.activities(cooperative_id)
  	activities = Cooperative.find(cooperative_id).activities.split("\, ")
    activities_map = Hash[*activities.zip(activities).flatten]
  end
end
