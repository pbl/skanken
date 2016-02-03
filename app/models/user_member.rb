class UserMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :member
  validates_presence_of :user_id, :member_id
  validates_uniqueness_of :member_id, scope: :user_id
end
