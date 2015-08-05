class JobsController < ApplicationController
  before_filter :authenticate_user!

  def create
    date = date_today
    job_params_merged = job_params.merge(:date => date)

    @member = Member.find(params[:member_id])
    @job = @member.jobs.new(job_params_merged)
    @job.save
    @member.nbr_jobs = @member.jobs.length
    @member.save
    redirect_to table_table_path
  end

  def destroy
    @member = Member.find(params[:member_id])
    @job = @member.jobs.find(params[:id])
    @job.destroy
    @member.nbr_jobs = @member.jobs.length
    @member.save
    @cooperative = Cooperative.find(current_user.cooperative_id)
    redirect_to cooperative_member_path(@cooperative, @member)
  end

  private
    def job_params
      params.require(:job).permit(:date, :activity, :comment)
    end
end