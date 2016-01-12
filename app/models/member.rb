class Member < ActiveRecord::Base
  has_many :contacteds, dependent: :destroy
  has_many :activities, through: :member_activities
  has_many :member_activities
  belongs_to :cooperative

  validates_presence_of :name, :mobile
  scope :has_name, -> (name) { where('lower(name) like :search', search: "%#{name.try(:downcase)}%")}
  
  def self.as_csv
    mobile = 1
    date1 = 4
    date2 = 5
    CSV.generate do |csv|
      column_names = ['name', 'mobile', 'email', 'date_of_birth', 'last_contacted', 'created_at']
      csv << column_names + ['activities']
      all.each do |member|
        member_activities = member.activities.pluck(:name).join(", ")
        member_columns = member.attributes.values_at(*column_names)
        member_columns[mobile] = member_columns[mobile].insert(3, '-') if member_columns[mobile].length > 3
        member_columns[date1] = member_columns[date1].try(:strftime, "%F")
        member_columns[date2] = member_columns[date2].try(:strftime, "%F")
        csv << member_columns + [member_activities]
      end
    end
  end  
end
