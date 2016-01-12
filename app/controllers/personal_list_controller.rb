class PersonalListController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :set_cooperative
  before_action :set_member, :set_activity_from_param, only: [:add]

  def index
    page = params[:page] || 1
    @user_members = current_user.user_members
    @members = current_user.members.order(name: :asc).page(page)
  end

  def add
    current_user.members << @member
    flash[:success] = t('personal_list.added', name: @member.name)
    redirect_to randomizer_show_path(activity_id: @activity.id)
  end

  def destroy
    # todo
  end

  private 

  def set_member
    @member = @cooperative.members.find_by_id(params[:member_id])
    record_exists?(@member)
  end

  def set_activity_from_param
    @activity = current_user.cooperative.activities.find_by_id(params[:activity_id])
    record_exists?(@activity)
  end
end
