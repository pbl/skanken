class Cooperative < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates_presence_of :name

end
