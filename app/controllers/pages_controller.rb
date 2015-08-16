class PagesController < ApplicationController
  before_filter :user_start_page, only: [:start]
  layout 'startpage'

  def start
  end

  # def about
  # end

end
