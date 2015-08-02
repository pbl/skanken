class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :activity, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
