class TableController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :set_activity_id, only: [:create]
  before_action :set_cooperative, only: [:choose]

  def choose
    @activities = @cooperative.activities
    @user = current_user
  end

  # need to be finished
  def create
    activity = Activity.find(@activity_id)
    current_user.activities.delete_all
    current_user.activities << activity
    redirect_to members_path
  end

  private

  def set_activity_id
    @activity_id = params[:choose].try(:[], :activity_id).nil? ? 0 : params[:choose].try(:[], :activity_id).to_i
    return true unless @activity_id == 0
    render nothing: true, status: 401
  end
end
