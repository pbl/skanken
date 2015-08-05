class Search
  # attr_reader :query

  def initialize(cooperative, activity)
    @cooperative = cooperative
    @activity = activity
  end

  def search(opts)
    page = opts.fetch(:page)
    query = opts.fetch(:query)
    @activity.members.has_name(query).order(name: :asc).page(page)
  end
end