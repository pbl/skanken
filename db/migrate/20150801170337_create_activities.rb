class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :cooperative, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :activities, :cooperatives
  end
end
