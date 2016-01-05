class DropUserActivities < ActiveRecord::Migration
  def change
    drop_table :user_activities
  end
end
