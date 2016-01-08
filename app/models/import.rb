require 'csv'

class Import

  def initialize(file, cooperative)
    @csv_file = CSV.read(file.path, headers: true)
    @cooperative = cooperative
  end

  def import
    failed_imports = []
    @csv_file.each_with_index do |row, index|
      name = parse_name(row['name'])
      mobile = parse_mobile(row['mobile'])
      email = parse_email(row['email'])
      date_of_birth = parse_date_of_birth(row['date_of_birth'])
      created_at = parse_created_at(row['created_at'])
      activities = row['activities']
      # asd
      # if !(activities.nil? || name.nil? || mobile.nil?)
      # else
      # end
      member = @cooperative.members.create(name: name, mobile: mobile, email: email, date_of_birth: date_of_birth, created_at: created_at)
      member.activities = add_activities(activities)
    end
  end

  private

  def parse_date_of_birth date_of_birth
    return date_of_birth unless date_of_birth.nil?
    ''
  end

  def parse_email email
    return email unless email.nil?
    ''
  end

  def parse_name(name)
    return name.strip unless !name.is_a?(String)
    ''
  end

  def add_activities name_activities
    member_activities = name_activities.try(:split, ",")
    member_activities.map! {|name| name.strip}
    activities = []
    member_activities.each do |activity_name|
      activity_name.downcase!
      # pretty sure next 4 lines can be replaced by find__or_create_by(name: activity_name)
      activity = @cooperative.activities.find_by(name: activity_name)
      if activity.nil?
        activity = @cooperative.activities.create(name: activity_name)
      end
      activities << activity
    end
    activities
  end

  def parse_created_at time
    created_at = time.try(:split, " ").try(:first).try(:split, "-")
    return Time.now if created_at.nil?
    Time.new(created_at[0], created_at[1], created_at[2])
  end

  def parse_mobile(mobile)
    mobile = mobile.try(:strip).try(:delete, '-') || ''
    mobile = mobile.gsub(/[^0-9,.]/, '')
    mobile = mobile.prepend('0') if mobile.start_with?('7')
    mobile = mobile.insert(3, '-') if mobile.length > 3
    mobile
  end

end