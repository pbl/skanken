class RemoveActivitiesField < ActiveRecord::Migration
  def change
    remove_column :cooperatives, :activities
    remove_column :members, :activities
  end
end
