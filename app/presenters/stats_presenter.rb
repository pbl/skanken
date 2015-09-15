# Stats presenter class
class StatsPresenter < BasePresenter
  # Search presenter attributes
  ATTRIBUTES = [:model, :column, :group_by, :from_date, :to_date]
  attr_accessor(*ATTRIBUTES)

  def initialize(params = {}, with: [])
    super
  end

  def models
    %w(activity contacted cooperative job member member_activity search user user_activity)
      .map { |m| [m.humanize, m.camelize] }
  end

  def group_bys
    Stats::DateGroup::TYPES
      .map { |m| [m.humanize, m] }
  end

  def columns
    %w(created_at updated_at).map { |col| [col.humanize, col] }
  end

  def humanize_collection(collection)
    collection
  end

  def chart_params
    params = {}
    ATTRIBUTES.each { |a| params[a] = public_send(a) }
    params
  end
end
