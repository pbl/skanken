class ContactedsController < ApplicationController
  prepend_before_filter :authenticate_user!, :set_member, only: [:add, :destroy]
  before_filter :set_contacted, only: [:destroy]
  before_filter :set_activity_name, only: [:add]

  def add
    @contacted = @member.contacteds.create(activity: @activity_name)
    update_member
    redirect_to table_all_path
  end

  def destroy
    @contacted.destroy
    update_member
    redirect_to member_path(@member)
  end

  private

  def set_activity_name
    @activity_name = current_user.activities.first.try(:name)
    return true unless @activity_name.nil?
    render nothing: true, status: 401
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
