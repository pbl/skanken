class TableController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :set_cooperative

  def all
    page = params[:page] || 1
    @search_form = SearchPresenter.new(params)
    query = @search_form.query || ''
    search = Search.new(@cooperative)
    @members = search.search(page: page, query: query, activity_id: @search_form.activity_id)
  end

end
