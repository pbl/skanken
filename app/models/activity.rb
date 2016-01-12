class Activity < ActiveRecord::Base
  belongs_to :cooperative
  has_many :members, through: :member_activities

  has_many :member_activities, dependent: :destroy
  validates_presence_of :name, :cooperative_id
end
