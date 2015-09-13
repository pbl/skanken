class JobsController < ApplicationController
  prepend_before_filter :authenticate_user!, :set_member
  before_filter :ensure_user_has_activity, only: [:create]
  before_filter :set_job, only: [:destroy]

  def create
    job = @member.jobs.new(job_params)
    if job.save
      current_user.jobs << job
      @activity.jobs << job
      update_member
      redirect_to table_all_path
    else
      render nothing: true, status: 401
    end
  end

  def destroy
    @job.destroy
    update_member
    redirect_to member_path(@member)
  end

  private

  def set_job
    @job = @member.jobs.find_by_id(params[:id])
    return true unless @job.nil?
    render nothing: true, status: 401
  end

  def update_member
    @member.nbr_jobs = @member.jobs.size
    @member.save
  end

  def ensure_user_has_activity
    @activity = current_user.activities.first
    return true unless @activity.nil?
    render nothing: true, status: 401
  end

  def job_params
    params.require(:job).permit(:comment)
  end
end