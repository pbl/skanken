class ContactedsController < ApplicationController
  prepend_before_filter :authenticate_user!, :set_member, only: [:create, :destroy]
  before_filter :set_contacted, only: [:destroy]

  def create
    activity_name = Activity.find_by_id(contacted_params['activity_id']).try(:name)
    @contacted = @member.contacteds.new(activity: activity_name)
    if @contacted.save
      update_member
    else
      flash[:warning] = t('contacted_form.error_no_activity')
    end
    redirect_to table_all_path
  end

  def destroy
    @contacted.destroy
    update_member
    redirect_to member_path(@member)
  end

  private

  def contacted_params
    params.require(:contacted).permit(:activity_id)
  end

  def update_member
    @member.nbr_contacteds = @member.contacteds.size
    last_contacted = @member.contacteds.last
    last_contacted = last_contacted.nil? ? nil : last_contacted.created_at
    @member.last_contacted = last_contacted
    @member.save
  end

  def set_contacted
    @contacted = @member.contacteds.find_by_id(params[:id])
    return true unless @contacted.nil?
    render nothing: true, status: 401
  end

end
