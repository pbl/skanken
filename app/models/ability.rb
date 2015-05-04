class Ability
  include CanCan::Ability

  def initialize(user)
		# Handle the case where we don't have a current_user i.e. the user is a guest
		user ||= User.new

		if user.is? :admin
			can :manage, :all
		elsif user.is? :cooperative_admin
			can :manage, :all, :active => true, :cooperative_id => user.cooperative_id
		elsif user.is? :foreman
			can :manage, Member, :active => true, :cooperative_id => user.cooperative_id
			can :manage, Job, :active => true, :cooperative_id => user.cooperative_id
			can :manage, Contacted, :active => true, :cooperative_id => user.cooperative_id
		else
			can :manage, Info
		end
  end
end
