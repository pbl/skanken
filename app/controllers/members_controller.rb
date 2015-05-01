class MembersController < ApplicationController
	before_filter :authenticate_user!	
	before_filter :ensure_cooperative
	before_filter :admin?, only: [:admin, :import]

	def index
    @members = Member.all
  end

  def temp
  	@member = Member.find(1)
  end

	def create
		date = date_today
		activities = params["member"]["activities"].to_s
		merged_worker_params = worker_params.merge(:dateAdded => date_today, :activities => activities)

		@member = Member.new(merged_worker_params)

	  if @member.save
		  redirect_to members_path
		else
			render 'new'
		end
	end

	def new
	end

	def show
    @member = Member.find(params[:id])
  end

  def edit
	  @member = Member.find(params[:id])
	end


	def update
		@member = Member.find(params[:id])
		
		activities = params["member"]["activities"].to_s
		merged_worker_params = worker_params.merge(:activities => activities)
		
		@member.update(merged_worker_params)
		redirect_to @member
	end

	def destroy
	  @member = Member.find(params[:id])
	  @member.destroy	 
	  redirect_to members_path
	end

	def creators
	end

	def admin	
	end

	def import
		Member.import(params[:file])
	  # redirect_to root_url, notice: "Products imported."
		redirect_to admin_path
	end

	private
	  def worker_params
	    params.require(:member).permit(:name, :mobile, :email, :personId, :activities, :comment, :dateAdded)
	  end
end
