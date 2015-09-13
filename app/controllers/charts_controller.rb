class ChartsController < ApplicationController
  def created_date
    column = params[:column] || 'created_at'
    group_by = params[:group_by] || 'day'
    model = params[:model].try(:constantize) || Member

    grouped_count = Stats::Date.call(scope: model, group_by: group_by, column: column).count
    render json: grouped_count
  end
end
