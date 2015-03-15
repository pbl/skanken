class MembersController < ApplicationController
	
	def index
    @members = Member.all
  end

	def new
	end

	def create
		@member = Member.new(member_params)
	  @member.save
	  redirect_to @member
	end

	def show
    @member = Member.find(params[:id])
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
	end

	private
	  def member_params
	    params.require(:member).permit(:name, :mobile, :email)
	  end
end
