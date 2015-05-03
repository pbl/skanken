class Cooperative < ActiveRecord::Base
  # has_many :jobs, through: :members
  # has_many :contacteds, through: :members
  has_many :users
  has_many :members

  validates_presence_of :name

  def self.activities cooperative_id
  	activities = Cooperative.find(cooperative_id).activities.split("\, ")
    
    # duplicating each value to be able to make it into a hash
    duplicate = Array.new

    activities.each do |activity|
      duplicate << activity
      duplicate << activity
    end

    duplicate = duplicate.sort
    Hash[*duplicate]
  end

end

# def self.activities
#   activites_map = Member::ACTIVITES
#   activites_map.to_a.map! { |arr| [arr.first.to_s.humanize, arr.last] }
# end