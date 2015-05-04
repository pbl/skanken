class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :cooperative
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[admin cooperative_admin foreman no_role]

  validates_inclusion_of :role, in: ROLES

  def self.cooperative_roles
    ROLES - ["admin"] - ["no_role"]
  end

  def is?( requested_role )
    self.role == requested_role.to_s
  end
end
