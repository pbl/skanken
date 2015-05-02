class ContactedsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_same_cooperative

  def create
    date = date_today
    contacted_params_merged = contacted_params.merge(:date => date)

    @member = Member.find(params[:member_id])
    @contacted = @member.contacteds.new(contacted_params_merged)
    @contacted.save
    redirect_to cooperative_members_path
  end

  def destroy
    @member = Member.find(params[:member_id])
    @contacted = @member.contacteds.find(params[:id])
    @contacted.destroy
    redirect_to cooperative_members_path
  end

  private
    def contacted_params
      params.require(:contacted).permit(:date, :activity, :comment)
    end
end