class UserMembersController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :set_cooperative
  before_action :set_member, :set_activity_from_param, only: [:create]

  def index
    page = params[:page] || 1
    @user_members = current_user.user_members
    @members = current_user.members.order(name: :asc).page(page)
  end

  def create
    user_member = UserMember.new(user_id: current_user.id, member_id: @member.id, comment: user_member_params[:comment])
    user_member.user = current_user
    user_member.member = @member
    if user_member.save
      flash[:success] = t('user_member.added', name: @member.name)
      redirect_to randomizer_show_path(activity_id: @activity.id)
    else
      render nothing: true, status: 403
    end
  end

  def destroy
    # todo
  end

  private 

  def user_member_params
    params.require(:user_member).permit(:comment, :member_id)
  end

  def set_member
    @member = @cooperative.members.find_by_id(user_member_params[:member_id])
    record_exists?(@member)
  end

  def set_activity_from_param
    @activity = current_user.cooperative.activities.find_by_id(params[:activity_id])
    record_exists?(@activity)
  end
end
