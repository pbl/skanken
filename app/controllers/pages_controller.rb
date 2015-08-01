class PagesController < ApplicationController
  before_filter :user_start_page

  def start
  end
end
