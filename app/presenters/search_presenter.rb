# Search presenter class
class SearchPresenter < BasePresenter
  # Search presenter attributes
  ATTRIBUTES = [:query, :activity_id]
  attr_accessor(*ATTRIBUTES)

  def initialize(params = {}, with: [])
    super
  end
end
