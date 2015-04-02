class ContactedsController < ApplicationController
	def create
    @member = Member.find(params[:member_id])
    @contacted = @member.contacteds.create(contacted_params)
    redirect_to member_path(@member)
  end

  # def update
  # end

  # def edit
  # end

  def destroy
  	@member = Member.find(params[:member_id])
    @contacted = @member.contacteds.find(params[:id])
	  @contacted.destroy	 
	  redirect_to member_path(@member)
  end
 
  private
    def contacted_params
      params.require(:contacted).permit(:date, :for, :comment)
    end
end
