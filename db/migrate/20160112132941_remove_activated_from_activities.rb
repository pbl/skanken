class RemoveActivatedFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :activated, :boolean
  end
end
