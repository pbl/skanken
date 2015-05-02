class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :cooperative


  ROLES = {
    no_role:          -1,
    member:            1,
    cooperative_admin: 2,
    admin:             1337
  }
  validates_inclusion_of :user_role, in: ROLES.values
  # PUBLIC_REG_ROLES = [:tenant, :cooperative_admin]


  ROLES.keys.each do |role|
    scope "#{role}s", -> { where(user_role: ROLES[role]) }
  end

  ROLES.keys.each do |role|
    define_method("#{role}?") do
      self[:user_role].eql?(ROLES[role])
    end
  end

  def self.zip_user_roles(only = :all)
    user_roles = User::ROLES
    user_roles = user_roles.reject { |e| e == :no_role ||  e == :admin } if only == :registration
    user_roles.to_a.map! { |arr| [arr.first.to_s.humanize, arr.last] }
  end

end
