class Search

  def initialize(cooperative)
    @cooperative = cooperative
  end

  def search(opts)
    page = opts.fetch(:page)
    query = opts.fetch(:query)
    activity_id = opts.fetch(:activity_id)
    records = @cooperative.activities.find_by_id(activity_id).try(:members) || @cooperative.members
    records.has_name(query).order(name: :asc).page(page)
  end
end