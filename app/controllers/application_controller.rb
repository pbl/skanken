class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def no_access
    render nothing: true, status: 401
  end

  def update_member
    @member.nbr_contacteds = @member.contacteds.size
    last_contacted = @member.contacteds.last
    last_contacted = last_contacted.nil? ? nil : last_contacted.created_at
    @member.last_contacted = last_contacted
    @member.save
  end

  def set_activity_from_param
    @activity = current_user.cooperative.activities.find_by_id(params[:activity_id])
    record_exists?(@activity)
  end

  def set_cooperative
    @cooperative = current_user.cooperative
  end

  def record_exists?(record, status = 403)
    return true unless record.nil?
    render nothing: true, status: status
  end

  def ensure_cooperative_admin
    return true if current_user.is?(:cooperative_admin)
    render nothing: true, status: 401
  end

  def user_start_page
    return true unless user_signed_in?
    redirect_to table_all_path
  end

  def set_member
    @member = current_user.cooperative.members.find_by_id(params[:member_id])
    record_exists?(@member)
  end

end
