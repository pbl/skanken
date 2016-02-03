class UserMembersController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :set_cooperative
  before_action :set_member, :set_activity_from_param, only: [:create]
  before_action :set_user_member, only: [:destroy, :update]

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
      redirect_to request.referer
    elsif user_member.errors.any? # user_member must have an unique member_id and user_id
      flash[:warning] = t('user_member.not_unique', name: @member.name)
      redirect_to request.referer
    else
      render nothing: true, status: 403
    end
  end

  def update
    @user_member.update(update_user_member_params)
    redirect_to user_members_path
  end

  def destroy
    @user_member.destroy
    redirect_to user_members_path
  end

  private 

  def set_user_member
    @user_member = current_user.user_members.find_by_id(params[:id])
    record_exists?(@user_member)
  end

  def update_user_member_params
    params.require(:user_member).permit(:comment)
  end

  def user_member_params
    params.require(:user_member).permit(:comment, :member_id)
  end

  def set_member
    @member = @cooperative.members.find_by_id(user_member_params[:member_id])
    record_exists?(@member)
  end

  def set_activity_from_param
    @activity_id = current_user.cooperative.activities.find_by_id(params[:activity_id]).try(:id)
  end
end
