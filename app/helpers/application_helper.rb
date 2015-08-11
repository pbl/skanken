module ApplicationHelper

  def date date
    date.strftime("%d %b. %Y")
  end

  def format_statistics_info(stat)
    return stat unless stat.is_a?(ActiveRecord::Base)
    stat.name
  end

  def admin_active_class
    paths = []
    paths << cooperative_accounts_path(@cooperative)
    paths << new_cooperative_account_path(@cooperative)
    paths << edit_cooperative_path(@cooperative)
    paths << cooperative_admin_path(@cooperative)
    paths.each do |path|
      return active_class(path) if active_class(path).eql? 'active'
    end
    return ''
  end

  def active_class(link_path)
    current_page?(link_path) ? 'active' : ''
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
