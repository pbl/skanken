class Job < ActiveRecord::Base
  belongs_to :member

  	validates_presence_of :activity
end
