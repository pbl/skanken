class JobsController < ApplicationController
	def create
    @member = Member.find(params[:member_id])
    @job = @member.jobs.create(job_params)
    redirect_to member_path(@member)
  end

  # def update
  # end

  # def edit
  # end

  def destroy
  	@member = Member.find(params[:member_id])
    @job = @member.jobs.find(params[:id])
	  @job.destroy	 
	  redirect_to member_path(@member)
  end
 
  private
    def job_params
      params.require(:job).permit(:date, :activity, :comment)
    end

end
