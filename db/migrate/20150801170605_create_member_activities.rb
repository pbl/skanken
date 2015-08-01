class CreateMemberActivities < ActiveRecord::Migration
  def change
    create_table :member_activities do |t|
      t.belongs_to :activity, index: true, foreign_key: true
      t.belongs_to :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
