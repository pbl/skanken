class MemberActivity < ActiveRecord::Base
  belongs_to :activity
  belongs_to :member
  validates_presence_of :activity_id, :member_id
end
