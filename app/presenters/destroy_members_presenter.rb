# DestroyMember presenter class
class DestroyMembersPresenter < BasePresenter
  # DestroyMember presenter attributes
  ATTRIBUTES = [:date]
  attr_accessor(*ATTRIBUTES)

  def initialize(params = {}, with: [])
    super
  end
end
