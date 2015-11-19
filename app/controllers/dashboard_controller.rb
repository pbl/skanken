class DashboardController < ApplicationController
  def overview
    @stats_form = StatsPresenter.new(params)
  end
end
