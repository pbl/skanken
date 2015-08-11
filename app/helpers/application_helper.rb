module ApplicationHelper

  def date date
    date.strftime("%d %b. %Y")
  end

  def format_statistics_info(stat)
    return stat unless stat.is_a?(ActiveRecord::Base)
    stat.name
  end

  def table_creator(records, header_names, column_functions)
    header = ''
    header_names.each do |name|
      header += "<th>#{name}</th>"
    end
    rows = ''
    records.each do |record|
      row = '<tr>'
      columns = ''
      column_functions.each do |proc|
        columns += "<td>#{proc.call(record)}</td>"
      end
      row += "#{columns} </tr>"
      rows += row
    end

    table = "<table class='table'>
              <thead>
                <tr>
                  #{header}
                </tr>
              </thead>
              <tbody>
                #{rows}
              </tbody>
            </table>"
    table.html_safe
  end
end
