class ChangeColumnsMembers < ActiveRecord::Migration
  def change
    remove_column :members, :dateAdded
    rename_column :members, :personId, :date_of_birth
  end
end
