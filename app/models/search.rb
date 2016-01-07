class Search

  def initialize(cooperative)
    @cooperative = cooperative
  end

  def search_members(opts)
    page = opts.fetch(:page)
    query = opts.fetch(:query)
    activity_id = opts.fetch(:activity_id)
    records = @cooperative.activities.find_by_id(activity_id).try(:members) || @cooperative.members
    records.has_name(query).order(name: :asc).page(page)
  end

  def search_accounts(opts)
    page = opts.fetch(:page)
    query = opts.fetch(:query)
    records = @cooperative.users
    records.has_email(query).order(email: :asc).page(page)
  end
end