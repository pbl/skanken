module ApplicationHelper

  def date date
    date.strftime("%d %b. %Y")
  end

  def format_statistics_info(stat)
    return stat unless stat.is_a?(ActiveRecord::Base)
    stat.name
  end
end
