class ContactedsController < ApplicationController
	
  def create
    time = Time.new
    unformatTime = Time.local(time.year, time.month, time.day).to_s
    formattedTime = unformatTime.gsub(/\s+/m, ' ').strip.split(" ")[0]
    activity = params[:activity]

    contactedParams = contacted_params.merge(:date => formattedTime, :activity => activity)



    @member = Member.find(params[:member_id])
    @contacted = @member.contacteds.new(contactedParams)
    @contacted.save
    redirect_to members_path
  end

  def destroy
  	@member = Member.find(params[:member_id])
    @contacted = @member.contacteds.find(params[:id])
	  @contacted.destroy	 
	  redirect_to members_path
  end
 
  private
    def contacted_params
      params.require(:contacted).permit(:date, :activity, :comment)
    end
end