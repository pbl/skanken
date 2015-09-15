module Query
  class DateFilter
    def self.call(scope:, column:, from: nil, to: nil)
      from  = from.blank? ? Date.new(2015, 1, 1) : from.to_date
      to = to.blank? ? Date.tomorrow : to.to_date

      scope.where(column.to_sym => from..to)
    end
  end
end
