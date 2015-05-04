class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_cooperative_admin?
    return true unless current_user.user_role != 2
    redirect_to(root_path)
  end

  def ensure_same_cooperative
    return true unless (current_user.cooperative_id != Member.find(params[:member_id]).cooperative_id)
  end

  def ensure_cooperative
    return true unless (current_user.cooperative_id.nil?)
    redirect_to new_cooperative_path
  end

  private
    def date_today
      time = Time.new
      unformatTime = Time.local(time.year, time.month, time.day).to_s
      formattedTime = unformatTime.gsub(/\s+/m, ' ').strip.split(" ")[0]
      return formattedTime
    end
end
