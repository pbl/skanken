class Ability
  include CanCan::Ability

  def initialize(user)
	# Handle the case where we don't have a current_user i.e. the user is a guest
	user ||= User.new

	# Define a few sample abilities
	# cannot :manage , Comment
	# can    :read   , Tag , released: true
# asd
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

	# Define abilities for the passed in user here. For example:
	#
	#   user ||= User.new # guest user (not logged in)
	#   if user.admin?
	#     can :manage, :all
	#   else
	#     can :read, :all
	#   end
	#
	# The first argument to `can` is the action you are giving the user
	# permission to do.
	# If you pass :manage it will apply to every action. Other common actions
	# here are :read, :create, :update and :destroy.
	#
	# The second argument is the resource the user can perform the action on.
	# If you pass :all it will apply to every resource. Otherwise pass a Ruby
	# class of the resource.
	#
	# The third argument is an optional hash of conditions to further filter the
	# objects.
	# For example, here the user can only update published articles.
	#
	#   can :update, Article, :published => true
	#
	# See the wiki for details:
	# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
