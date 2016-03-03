class RandomizerController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_action :set_activity_from_param, only: [:show, :no_answer]
  before_filter :set_cooperative
  before_action :set_member, only: [:no_answer]
  before_action :parse_next_time_params, only: [:next_time]

  def category
    @activities = @cooperative.activities
  end

  def no_answer
    @member.contacteds.create(activity: @activity.name, comment: @comment)
    redirect_to request.referer
  end

  def next_time
    @member.contacteds.create(activity: @activity.name, comment: @comment)
    redirect_to request.referer
  end

  def show
    @user_member = UserMember.new
    @contacted = Contacted.new
    # only show members who are not in the current_user user_member list
    members = @activity.members - current_user.members
    if(members.count > 0)
      @member = get_least_contacted_member(members)
    else
      flash[:warning] = t('randomizer.no_member_in_category', activity: @activity.name)
      redirect_to randomizer_category_path     
    end
  end

  private

  def parse_next_time_params
    @member = current_user.cooperative.members.find_by_id(params[:format])
    form_params = params.require(:contacted).permit(:activity, :comment)
    @activity = current_user.cooperative.activities.find_by_id(form_params.try('[]' ,:activity))
    @comment = form_params.try('[]' ,:comment)
    record_exists?(@comment)
    @comment = t('randomizer.default_next_time_comment') if @comment.empty?
    record_exists?(@member)
    record_exists?(@activity)
  end

  def set_member
    @member = current_user.cooperative.members.find_by_id(params[:member_id])
    record_exists?(@member)
  end

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
