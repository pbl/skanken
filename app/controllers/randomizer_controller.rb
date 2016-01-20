class RandomizerController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_action :set_activity_from_param, only: [:show]
  before_filter :set_cooperative

  def category
    @activities = @cooperative.activities
  end

  def show
    @user_member = UserMember.new
    i = 1
    while @member.nil? && i < 100
      i += 1
      @member = @activity.members.where('nbr_contacteds < ?', i).sample
    end
    if @member.nil?
      flash[:warning] = t('randomizer.no_member_in_category', activity: @activity.name)
      redirect_to randomizer_category_path
    else
      @member.contacteds.create(activity: @activity.name)
      update_member
    end
  end

  private

  def set_activity_from_param
    @activity = current_user.cooperative.activities.find_by_id(params[:activity_id])
    record_exists?(@activity)
  end
end
