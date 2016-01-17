class PageController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_filter :set_cooperative

  def start
  end
end
