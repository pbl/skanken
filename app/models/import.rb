require 'csv'

class Import

  def initialize(cooperative)
    @cooperative = cooperative
  end

  def import(file)
    return false if no_file?(file)
    return false if wrong_format?(file)
    csv_file = CSV.read(file.path, headers: true)
    return false if wrong_headers?(csv_file.headers)
    failed_imports = []
    members = []
    csv_file.each_with_index do |row, index|
      @name = parse_name(row['name'])
      @mobile = parse_mobile(row['mobile'])
      @email = parse_email(row['email'])
      @date_of_birth = parse_date_of_birth(row['date_of_birth'])
      @created_at = parse_created_at(row['created_at'])
      @member_activities = parse_activities(row['activities'])
      if valid_columns?
        members << new_member
      else
        failed_imports << (index + 2)
      end
    end
    return false if failed_imports?(failed_imports)
    save_members(members)
    true
  end

  def error_msg
    @error_msg
  end

  private

  def failed_imports?(failed_imports)
    if !failed_imports.empty?
      @error_msg = I18n.t('import.failed_members', row: failed_imports.join(", "))
      return true
    end
    false
  end

  def wrong_headers?(headers)
    if !(headers.include?("mobile") && headers.include?("name") && headers.include?("activities"))
      @error_msg = I18n.t('import.wrong_headers')
      return true
    end
    false
  end

  def no_file?(file)
    if file.nil?
      @error_msg = I18n.t('import.no_file')
      return true
    end
    false
  end

  def wrong_format?(file)
    if !file.original_filename.end_with?(".csv")
      @error_msg = I18n.t('import.not_csv')
      return true
    end
    false
  end

  def save_members(members)
    members.map {|member_arr| 
      member = member_arr.first
      member.save
      member.activities = find_or_create_activities(member_arr.second)
    }
  end

  def new_member
    member = []
    member << @cooperative.members.new(name: @name, mobile: @mobile, email: @email, 
      date_of_birth: @date_of_birth, created_at: Time.now)  
    member << @member_activities
    member
  end

  def valid_columns?
    !(@member_activities.empty? || @name.empty? || @mobile.empty?)
  end

   def find_or_create_activities(activities_name)
    activities = []
    activities_name.map {|activity_name| activities << @cooperative.activities.find_or_create_by!(name: activity_name) }
    activities
  end

  def parse_date_of_birth(date_of_birth)
    return date_of_birth unless date_of_birth.nil?
    ''
  end

  def parse_email(email)
    return email unless email.nil?
    ''
  end

  def parse_name(name)
    return name.strip unless name.nil?
    ''
  end

  def parse_activities(activities)
    return [] unless !activities.nil?
    activities = activities.split(",")
    activities = activities.map {|e| e.strip}
    activities = activities.reject{ |e| e.empty? }
    activities = activities.map {|e| e.downcase}
    activities
  end

  def parse_created_at(created_at)
    return Date.parse(created_at)
  rescue
    Time.new
  end

  def parse_mobile(mobile)
    mobile = mobile.try(:strip).try(:delete, '-') || ''
    mobile = mobile.gsub(/[^0-9,.]/, '')
    mobile = mobile.prepend('0') if mobile.start_with?('7')
    mobile = mobile.insert(3, '-') if mobile.length > 3
    mobile
  end
end
