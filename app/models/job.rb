class Job < ActiveRecord::Base
  belongs_to :member
  belongs_to :user
  belongs_to :activity

end
