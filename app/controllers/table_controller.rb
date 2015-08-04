class TableController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_action :set_cooperative, only: [:choose]

  def choose
    @activities = @cooperative.activities
    @user = current_user
  end

  # need to be finished
  def create
    asd
    activity = Activity.find_by_id(table_params)
    if !activity.nil?
      current_user.activities.delete_all
      current_user.activities = activity
      redirect_to members_path
    else
      render nothing: true, status: 401
    end
  end

  private

  def table_params
    params.permit(:activity_id)
  end
end
