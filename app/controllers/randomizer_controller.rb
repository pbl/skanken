class RandomizerController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :set_activity_from_param, only: [:show]
  before_filter :set_cooperative

  def category
    @activities = @cooperative.activities
  end

  def show
    i = 1
    while @member.nil?
      i += 1
      @member = @activity.members.where('nbr_contacteds < ?', i).sample
    end
    @member.contacteds.create(activity: @activity.name)
    update_member
  end

  private

  def set_activity_from_param
    @activity = current_user.cooperative.activities.find_by_id(params[:activity_id])
    record_exists?(@activity)
  end
end
