class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  def ensure_cooperative_created
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
