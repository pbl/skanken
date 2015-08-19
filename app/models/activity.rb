class Activity < ActiveRecord::Base
  belongs_to :cooperative
  has_many :users, through: :user_activities
  has_many :members, through: :member_activities

  has_many :member_activities, dependent: :destroy
  has_many :user_activities, dependent: :destroy
  has_many :jobs, dependent: :destroy
  validates_presence_of :name, :cooperative_id
end
