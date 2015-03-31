class MembersController < ApplicationController

	before_filter :authenticate_user!	

	def index
    @members = Member.all
  end

	def new
	end

	def create
		time = Time.new
		unformatTime = Time.local(time.year, time.month, time.day).to_s
		formattedTime = unformatTime.gsub(/\s+/m, ' ').strip.split(" ")[0]

		workerParams = member_params.merge(:dateAdded => formattedTime, :workCard => "None")
		
		@member = Member.new(workerParams)
	  @member.save
	  redirect_to @member
	end

	def show
    @member = Member.find(params[:id])
    # redirect_to members_path
  end

  def edit
	  @member = Member.find(params[:id])
	end


	def update
		@member = Member.find(params[:id])
		@member.update(member_params)
		redirect_to @member
	end

	def destroy
	  @member = Member.find(params[:id])
	  @member.destroy	 
	  redirect_to members_path
	end

	def search
	  @members = Member.search(params[:search])
	  # redirect_to members_path
	end

	private
	  def member_params
	    params.require(:member).permit(:name, :mobile, :email, :personId, :work, :comment, :dateAdded, :term, :workCard)
	  end
end
