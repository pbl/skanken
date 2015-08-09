class AddActivitadColumnToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :activated, :boolean, default: true
  end
end
