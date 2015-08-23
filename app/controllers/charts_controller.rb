class ChartsController < ApplicationController
  def member_created_date
    render json: Member.group_by_day(:created_at).count
  end
end
