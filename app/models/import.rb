require 'csv'

class Import

  def initialize(file, cooperative)
    @csv_file = CSV.read(file.path, headers: true)
    @cooperative = cooperative
  end

  def import
    failed_imports = []
    members = []
    @csv_file.each_with_index do |row, index|
      @name = parse_name(row['name'])
      @mobile = parse_mobile(row['mobile'])
      @email = parse_email(row['email'])
      @date_of_birth = parse_date_of_birth(row['date_of_birth'])
      @created_at = parse_created_at(row['created_at'])
      @member_activities = parse_activities(row['activities']) #todo fix so that new activities aren't added
      if valid_values?
        members << new_member
      else
        failed_imports << (index + 2)
      end
    end
    if failed_imports.empty?
      save_members(members)
    end
    failed_imports
  end

  private

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
      date_of_birth: @date_of_birth, created_at: @created_at)  
    member << @member_activities
    member
  end

  def valid_values?
    !(@member_activities.empty? || @name.empty? || @mobile.empty?)
  end

   def find_or_create_activities(activities_name)
    activities = []
    activities_name.map {|activity_name| activities << @cooperative.activities.find_or_create_by!(name: activity_name) }
    activities
  end

  def parse_date_of_birth date_of_birth
    return date_of_birth unless date_of_birth.nil?
    ''
  end

  def parse_email email
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
    activities = activities.reject{ |e| e.empty? }
    activities = activities.map {|e| e.strip}
    activities = activities.map {|e| e.downcase}
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
