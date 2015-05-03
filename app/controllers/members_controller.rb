class MembersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :ensure_cooperative

  def index
    cooperative_id = params[:cooperative_id]
    # this is needed since the this method is the website root
    if cooperative_id.nil?
      cooperative_id = current_user.cooperative_id
    end
    @cooperative = Cooperative.find(cooperative_id)
    @members = @cooperative.members.all
  end

  def create
    date = date_today
    activities = params["member"]["activities"].to_s
    merged_worker_params = worker_params.merge(:dateAdded => date_today, :activities => activities)

    @cooperative = Cooperative.find(params[:cooperative_id])
    @member = @cooperative.members.new(merged_worker_params)
    if @member.save
      redirect_to cooperative_members_path
    else
      render 'new'
    end
  end

  def new
    @cooperative = Cooperative.find(current_user.cooperative_id)
  end

  def show
    @cooperative = Cooperative.find(params[:cooperative_id])
    @member = @cooperative.members.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end


  def update
    @member = Member.find(params[:id])

    activities = params["member"]["activities"].to_s
    merged_worker_params = worker_params.merge(:activities => activities)

    @member.update(merged_worker_params)
    redirect_to cooperative_member_path
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to cooperative_members_path
  end

  private
    def worker_params
      params.require(:member).permit(:name, :mobile, :email, :personId, :activities, :comment, :dateAdded)
    end
end
