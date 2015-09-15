class ChartsController < ApplicationController
  def created_date
    column   = first_or_second(params[:column], 'created_at')
    group_by = first_or_second(params[:group_by], 'day')
    scope    = first_or_second(params[:model].try(:constantize), Member)

    date_params = {
      scope: scope,
      column: column,
      from: params[:from_date],
      to: params[:to_date]
    }
    scope = Query::DateFilter.call(date_params)

    grouped_count = Stats::DateGroup.call(scope: scope, column: column, group_by: group_by).count
    render json: grouped_count
  end

  private

  def first_or_second(first, second)
    first.blank? ? second : first
  end
end
