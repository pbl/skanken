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

  # PUBLIC_REG_ROLES = [:tenant, :cooperative_admin]

  # def self.is? user_role
  #   if user_role == :admin
  #     return self.user_role == 1337
  #   elsif user_role == :cooperative_admin
  #     return self.user_role == 2
  #   elsif user_role == :foreman
  #     return self.user_role == 1
  #   else
  #     return self.user_role == -1
  #   end
  # end

  # def self.role_name role_i
  #   name = ''
  #   if role_i == 1
  #     name = 'Foreman'
  #   elsif role_i == 2
  #     name = 'Cooperative admin'
  #   elsif role_i == -1
  #     name = 'No role'
  #   end
  #   return name      
  # end

  # def self.zip_user_roles(only = :all)
  #   user_roles = User::ROLES
  #   user_roles = user_roles.reject { |e| e == :no_role ||  e == :admin } if only == :registration
  #   user_roles.to_a.map! { |arr| [arr.first.to_s.humanize, arr.last] }
  # end

end
