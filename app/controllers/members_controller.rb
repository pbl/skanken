class MembersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :ensure_cooperative_created

	def index
		@cooperative = Cooperative.find(current_user.cooperative_id)
    @members = @cooperative.members.all
  end

	def create
		date = date_today
		activities = parse_activities params["member"]["activities"]
		merged_worker_params = worker_params.merge(:dateAdded => date_today, :activities => activities)

		@cooperative = Cooperative.find(current_user.cooperative_id)
		@member = @cooperative.members.new(merged_worker_params)
	  if @member.save
	  	flash[:success] = "#{params[:member][:name]} was successfully created. Helge vare gösta"
		  redirect_to cooperative_members_path
		else
			flash[:danger] = "Name, mobile and activities field must be filled in. Helge vare gösta"
			render 'new'
		end
	end

	def new
		@cooperative = Cooperative.find(current_user.cooperative_id)
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
		def parse_activities activities_param
			activities = activities_param
			# removes last empty element
			activities.delete("")
			activities.join(", ")
		end

	private
	  def worker_params
	    params.require(:member).permit(:name, :mobile, :email, :personId, :activities, :comment, :dateAdded)
	  end
end
