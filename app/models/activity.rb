class Activity < ActiveRecord::Base
  belongs_to :cooperative
  has_many :members, through: :member_activities
  has_many :member_activities
  has_many :users, through: :user_activities
  has_many :user_activities
  has_many :jobs
  validates_presence_of :name, :cooperative_id

  def get_activated(activities)
    activities.reject! {|activity| activity.activated}
  end

  def get_deactivated(activities)
  end
end
