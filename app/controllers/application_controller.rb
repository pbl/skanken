class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_cooperative_admin?
    return true unless current_user.user_role != 2
    flash[:danger] = "You dont have the access rights to this page. Helge vare gösta"
    redirect_to info_creators_path
  end

  # def ensure_correct_cooperative
  #   ad
  #   return true unless current_user.cooperative_id.to_s != params[:cooperative_id]
  #   flash[:danger] = "You dont have the access rights to this page. Helge vare gösta"
  #   redirect_to info_creators_path
  # end

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
