class UserActivity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  validates_presence_of :activity_id, :user_id
end
