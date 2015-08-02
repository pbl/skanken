class TableController < ApplicationController
  prepend_before_filter :authenticate_user!
  before_action :set_cooperative, only: [:activity]

  def choose
  end
end
