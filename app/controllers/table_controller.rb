class TableController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :activity_param, only: [:create]
  before_filter :set_activity, only: [:table]
  before_action :set_cooperative, only: [:choose, :table]

  def choose
    @activities = @cooperative.activities
    @user = current_user
  end

  def create
    activity = Activity.find(@activity_id)
    current_user.activities.delete_all
    current_user.activities << activity
    redirect_to table_table_path
  end

  def table
    page = params[:page].nil? ? 1 : params[:page]
    @search_form    = SearchPresenter.new(params)
    query = @search_form.query || ''
    search = Search.new(@cooperative, @activity)
    @members = search.search(page: page, query: query)
    # asd
    # asd
    # @members = @cooperative.members.page(page)
    # @search_form = SearchPresenter.new(params)
  end

  private

  def set_activity
    @activity = current_user.activities.first
    return true unless @activity.nil?
    redirect_to table_choose_path
  end

  def activity_param
    @activity_id = params[:choose].try(:[], :activity_id).nil? ? 0 : params[:choose].try(:[], :activity_id).to_i
    return true unless @activity_id == 0
    render nothing: true, status: 401
  end
end
