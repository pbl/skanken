class ContactedsController < ApplicationController
  prepend_before_filter :authenticate_user!, :set_member, only: [:add, :destroy]
  before_filter :set_contacted, only: [:destroy]

  def add
    activity = current_user.activities.try(:first).try(:name)
    if !activity.nil?
      @contacted = @member.contacteds.create(activity: activity)
      update_member
      redirect_to table_table_path
    else
      render nothing: true, status: 401
    end

  end

  def destroy
    @contacted.destroy
    update_member
    redirect_to member_path(@member)
  end

  private

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

  def set_member
    @member = Member.find_by_id(params[:member_id])
    return true unless @member.nil?
    render nothing: true, status: 401
  end
end
