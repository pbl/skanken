class Activity < ActiveRecord::Base
  belongs_to :cooperative
  has_many :members, through: :member_activities
end
