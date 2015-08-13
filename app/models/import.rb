require 'csv'

class Import

  def initialize(file, cooperative)
    @memberList = CSV.read(file.path, headers: true)
    @cooperative = cooperative
  end

  def import
    @memberList.each_with_index do |row, index|
      name          = parse_name(row['Namn'], row['Efternamn'])
      mobile        = parse_mobile(row['Telefonnummer'])
      email         = parse_email(row['Email'])
      date_of_birth = parse_date_of_birth(row['Personnummer'])
      created_at    = parse_created_at(row['x'])
      member = @cooperative.members.create(name: name, mobile: mobile, email: email, date_of_birth: date_of_birth, created_at: created_at)
      member.activities = add_activities(row['Vill Jobba'])
      # begin
      #   @contacted = member.contacteds.new(:date => Date.parse(row['Senast kontaktad'].to_s), :activity => 'Unknown', :comment => row['Kommentarer'].to_s)
      #   @contacted.save
      # rescue
      # end
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

  def parse_name(name, surname)
    "#{name} #{surname}".strip
  end

  def add_activities name_activities
    member_activities = name_activities.try(:split, ",") || [I18n.t('import.no_activity')]
    member_activities.map! {|name| name.strip}
    activities = []
    member_activities.each do |activity_name|
      activity_name.downcase!
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