class JobsController < ApplicationController
	
  def create
    date = date_today
    activity = params[:activity]
    jobParams = helper_params(:job).merge(:date => date, :activity => activity)

    @member = Member.find(params[:member_id])
    @job = @member.jobs.new(jobParams)
    @job.save
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