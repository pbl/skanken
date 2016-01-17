class ContactedsController < ApplicationController
  prepend_before_filter :authenticate_user!, :set_member
  before_filter :set_contacted

  def destroy
    @contacted.destroy
    update_member
    redirect_to member_path(@member)
  end

  private

  def contacted_params
    params.require(:contacted).permit(:activity_id)
  end

  def set_contacted
    @contacted = @member.contacteds.find_by_id(params[:id])
    return true unless @contacted.nil?
    render nothing: true, status: 401
  end

end
