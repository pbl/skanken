class RandomizerController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_action :set_activity_from_param, only: [:show]
  before_filter :set_cooperative

  def category
    @activities = @cooperative.activities
  end

  def show
    @user_member = UserMember.new
    # only show members who are not in the current_user user_member list
    members = @activity.members - current_user.members
    if(members.count > 0)
      @member = get_least_contacted_member(members)
      @member.contacteds.create(activity: @activity.name)
    else
      flash[:warning] = t('randomizer.no_member_in_category', activity: @activity.name)
      redirect_to randomizer_category_path     
    end
  end

  private

  def get_least_contacted_member(members)
    member = members.sample
    count = member.contacteds.count
    members.each do |other_member|
      other_count = other_member.contacteds.count
      if(count > other_count)
        member = other_member
        count = other_count
      end
    end
    member
  end

  def set_activity_from_param
    @activity = current_user.cooperative.activities.find_by_id(params[:activity_id])
    record_exists?(@activity)
  end
end
