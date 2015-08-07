class ContactedsController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :set_member, only: [:add]

  def add
    activity = current_user.activities.try(:first).try(:name)
    if !activity.nil?
      @contacted = @member.contacteds.create(activity: activity)
      @member.nbr_contacteds = @member.contacteds.size
      @member.last_contacted = Time.now.strftime("%d %b. %Y")
      @member.save
      redirect_to table_table_path
    else
      render nothing: true, status: 401
    end

  end

  def destroy
    @member = Member.find(params[:member_id])
    @contacted = @member.contacteds.find(params[:id])
    @contacted.destroy
    @member.nbr_contacteds = @member.contacteds.length
    if @member.contacteds.length == 0
      @member.last_contacted = "Never contacted"
    else
      @member.last_contacted = @member.contacteds.last.date
    end
    @member.save
    @cooperative = Cooperative.find(current_user.cooperative_id)
    redirect_to cooperative_member_path(@cooperative, @member)
  end

  private

    def set_member
      @member = Member.find_by_id(params[:member_id])
      return true unless @member.nil?
      render nothing: true, status: 401
    end

    def contacted_params
      params.require(:contacted).permit(:date, :activity, :comment)
    end
end
