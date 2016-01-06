class Member < ActiveRecord::Base
  has_many :contacteds, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :activities, through: :member_activities
  has_many :member_activities
  belongs_to :cooperative

  validates_presence_of :name, :mobile
  scope :has_name, -> (name) { where('lower(name) like :search', search: "%#{name.try(:downcase)}%")}
  
  def self.as_csv
    CSV.generate do |csv|
      column_names = ['name', 'mobile', 'email', 'date_of_birth', 'last_contacted', 'created_at']
      csv << column_names + ['aktiviteter']
      all.each do |member|
        member_activities = member.activities.pluck(:name).join(", ")
        member_columns = member.attributes.values_at(*column_names).map! {|val| val.try(:strftime, "%F") || val}
        csv << member_columns + [member_activities]
      end
    end
  end  
end
