class JobsController < ApplicationController
	
  def create
    time = Time.new
    unformatTime = Time.local(time.year, time.month, time.day).to_s
    formattedTime = unformatTime.gsub(/\s+/m, ' ').strip.split(" ")[0]
    activity = params[:activity]

    jobParams = job_params.merge(:date => formattedTime, :activity => activity)

    @member = Member.find(params[:member_id])
    @job = @member.jobs.new(jobParams)
    @job.save
    redirect_to members_path
  end

  def destroy
  	@member = Member.find(params[:member_id])
    @job = @member.jobs.find(params[:id])
	  @job.destroy	 
	  redirect_to members_path
  end
 
  private
    def job_params
      params.require(:job).permit(:date, :activity, :comment)
    end

end
