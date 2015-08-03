class MembersController < ApplicationController
	prepend_before_filter :authenticate_user!, :get_activities, only: [:create]
	before_action :set_cooperative, only: [:index, :new, :create]
	before_action :set_cooperative_activities, only: [:new, :create]

	def index
		page = params[:page].nil? ? 1 : params[:page]
    @members = @cooperative.members.page(page)
  end

	def create
		get_activities
		@member = @cooperative.members.new(member_params)
	  if !@activities_param.empty? && @member.save
	  	@member.activities = @activities_param
		  redirect_to member_path(@member)
		else
			if @activities_param.empty?
				@member.errors.add :activities, t('form.error_no_activity')
			end
			render 'new'
		end
	end

	def new
		@member = @cooperative.members.new
	end

	def show
		@cooperative = Cooperative.find(current_user.cooperative_id)
		@member = @cooperative.members.find(params[:id])
  end

  def edit
	  @member = Member.find(params[:id])
	end


	def update
		@member = Member.find(params[:id])
		activities = parse_activities params["member"]["activities"]

		merged_worker_params = worker_params.merge(:activities => activities)

		if @member.update(merged_worker_params)
	  	flash[:success] = "#{params[:member][:name]} was successfully updated. Helge vare gösta"
		  redirect_to cooperative_members_path
		else
			flash[:danger] = "Name, mobile and activities field must be filled in. Helge vare gösta"
			@cooperative = Cooperative.find(current_user.cooperative_id)
			redirect_to edit_cooperative_member_path
		end
	end

	def destroy
	  @member = Member.find(params[:id])
	  @member.destroy
	  redirect_to cooperative_members_path
	end

	private

	def set_cooperative_activities
		@activities = Cooperative.find(current_user.cooperative_id).activities
	end

	def get_activities
		activities_id = params[:member].try(:[], 'activities')
		activities_id = activities_id.nil? ? [] : activities_id
		activities_id = activities_id.reject {|id| id.empty?}
		@activities_param = Array.new
		activities_id.each do |id|
			@activities_param << Activity.find_by_id(id)
		end
		bad_params = @activities_param.any? {|activity| !activity.is_a?(ActiveRecord::Base) && current_user.cooperative_id == activity.cooperative_id}
		return true unless bad_params
		render nothing: true, status: 401
	end

	def set_cooperative
		@cooperative = Cooperative.find(current_user.cooperative_id)
 	end

	def parse_activities activities_param
		activities = activities_param
		# removes last empty element
		activities.delete("")
		activities.join(", ")
	end

  def member_params
    params.require(:member).permit(:name, :mobile, :email, :date_of_birth, :comment)
  end
end
