class Member < ActiveRecord::Base
  has_many :contacteds, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :activities, through: :member_activities
  has_many :member_activities
  belongs_to :cooperative

  validates_presence_of :name, :mobile
  scope :has_name, -> (name) { where('lower(name) like :search', search: "%#{name.try(:downcase)}%")}
end
