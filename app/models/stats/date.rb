module Stats
  class Date
    class UnknownGroupByType < ArgumentError; end

    TYPES = %w(hour day week month year)

    def self.call(scope:, column: 'created_at', group_by: 'day')
      case group_by.to_s
      when 'hour'  then scope.group_by_hour(column)
      when 'day'   then scope.group_by_day(column)
      when 'week'  then scope.group_by_week(column)
      when 'month' then scope.group_by_month(column)
      when 'year'  then scope.group_by_year(column)
      else
        fail(UnknownGroupByType, "Unknown group by type: '#{group_by}'")
      end
    end
  end
end
