class ContactedsController < ApplicationController
  before_filter :authenticate_user!

  def create
    date = date_today
    contacted_params_merged = contacted_params.merge(:date => date)
    @member = Member.find(params[:member_id])
    @contacted = @member.contacteds.new(contacted_params_merged)
    @contacted.save
    @member.nbr_contacteds = @member.contacteds.length
    @member.last_contacted = @member.contacteds.last.date
    @member.save
    redirect_to table_table_path
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
    def contacted_params
      params.require(:contacted).permit(:date, :activity, :comment)
    end
end