class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin?
  	actor_role = current_user.user_role.to_s
  	return true unless !(actor_role == '2' || actor_role == '1337')
  	redirect_to(root_path)
  end

  def ensure_cooperative
  	return true unless (current_user.cooperatives_id.nil?)
  	redirect_to new_cooperative_path
  end

  private 
  	def helper_destroy_method(controller_id)
  		@member = Member.find(params[:member_id])
    	# @contacted = @member.contacteds.find(params[:id])
    	@contacted = @member.contacteds.find(controller_id)
	  	@contacted.destroy	 
	  	redirect_to members_path
  	end

  private 
	  def date_today
	  	time = Time.new
			unformatTime = Time.local(time.year, time.month, time.day).to_s
			formattedTime = unformatTime.gsub(/\s+/m, ' ').strip.split(" ")[0]
			return formattedTime
	  end

	private 
		def helper_params controller
			params.require(controller).permit(:date, :activity, :comment)
		end
end
