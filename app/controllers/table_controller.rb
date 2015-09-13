class TableController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :set_activity_from_param, only: [:create]
  before_filter :user_activity, only: [:table]
  before_filter :set_cooperative, only: [:choose, :table]

  def choose
    @activities = @cooperative.activities.reject {|activity| !activity.activated}
    current_user.activities.delete_all
  end

  def create
    current_user.activities << @activity
    redirect_to table_table_path
  end

  def table
    @activity_selection = current_user.activities.first
    page = params[:page] || 1
    @search_form    = SearchPresenter.new(params)
    query = @search_form.query || ''
    search = Search.new(@cooperative, @activity)
    @members = search.search(page: page, query: query)
  end

  private

  def user_activity
    @activity = current_user.activities.first
    # return true unless @activity.nil?
    # redirect_to table_choose_path
  end

  def set_activity_from_param
    @activity = current_user.cooperative.activities.find_by_id(params[:activity_id])
    record_exists?(@activity)
  end
end
