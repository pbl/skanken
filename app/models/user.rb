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
  
  # PUBLIC_REG_ROLES = [:tenant, :cooperative_admin]

  # what is this?? 
  validates_inclusion_of :user_role, in: ROLES.values

  ROLES.keys.each do |role|
    scope "#{role}s", -> { where(user_role: ROLES[role]) }
  end

  ROLES.keys.each do |role|
    define_method("#{role}?") do
      self[:user_role].eql?(ROLES[role])
    end
  end

  # def self.public_reg_role?(role)
  #   PUBLIC_REG_ROLES.include?(ROLES.invert[role.to_i])
  # end

  # def user_role_name(append = nil)
  #   role_name = User::ROLES.invert[user_role]
  #   return role_name unless append
  #   "#{role_name}_#{append}".to_sym
  # end

  def self.zip_user_roles(only = :all)
    user_roles = User::ROLES
    user_roles = user_roles.reject { |e| e == :no_role ||  e == :admin } if only == :registration
    user_roles.to_a.map! { |arr| [arr.first.to_s.humanize, arr.last] }
  end

  # def to_s
  #   email
  # end


end
