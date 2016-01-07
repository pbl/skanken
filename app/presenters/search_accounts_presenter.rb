# Search presenter class
class SearchAccountsPresenter < BasePresenter
  # Search presenter attributes
  ATTRIBUTES = [:query]
  attr_accessor(*ATTRIBUTES)

  def initialize(params = {}, with: [])
    super
  end
end
