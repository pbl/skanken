class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_cooperative
    @cooperative = Cooperative.find(current_user.cooperative_id)
  end

  def user_start_page
    return true unless user_signed_in?
    redirect_to cooperative_members_path(Cooperative.find(current_user.cooperative_id))
  end

  private
  def date_today
    time = Time.new
    unformatTime = Time.local(time.year, time.month, time.day).to_s
    formattedTime = unformatTime.gsub(/\s+/m, ' ').strip.split(" ")[0]
    return formattedTime
  end
end
