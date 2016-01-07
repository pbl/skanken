class User < ActiveRecord::Base
  include ActiveModel::Validations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :cooperative
  has_many :jobs
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  ROLES = %w[admin cooperative_admin foreman no_role]
  COOPERATIVE_ROLES = ROLES - ['admin'] - ['no_role']
  validates_inclusion_of :role, in: (COOPERATIVE_ROLES)

  scope :has_email, -> (email) { where('lower(email) like :search', search: "%#{email.try(:downcase)}%")}


  def self.cooperative_roles
    ROLES - ['admin'] - ['no_role']
  end

  def is?( requested_role )
    self.role == requested_role.to_s
  end

end
