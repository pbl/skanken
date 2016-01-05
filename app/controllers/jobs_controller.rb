class JobsController < ApplicationController
  prepend_before_filter :authenticate_user!, :set_member
  before_filter :set_job, only: [:destroy]
  before_filter :set_cooperative, only: [:create]

  def create
    job = @member.jobs.new(job_params)
    if job.save
      current_user.jobs << job
      @cooperative.activities.find_by_id(job_params['activity_id']).jobs << job
      update_member
    else
      flash[:warning] = t('job_form.error_no_activity')
    end
    redirect_to table_all_path
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

  def job_params
    params.require(:job).permit(:comment, :activity_id)
  end
end