class JobsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_same_cooperative

  def create
    date = date_today
    job_params_merged = job_params.merge(:date => date)

    @member = Member.find(params[:member_id])
    @job = @member.jobs.new(job_params_merged)
    @job.save
    redirect_to cooperative_members_path
  end

  def destroy
    @member = Member.find(params[:member_id])
    @job = @member.jobs.find(params[:id])
    @job.destroy
    redirect_to cooperative_member_path
  end

  private
    def job_params
      params.require(:job).permit(:date, :activity, :comment)
    end
end