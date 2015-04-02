class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.date :date
      t.string :type
      t.text :comment
      t.references :member, index: true

      t.timestamps null: false
    end
    add_foreign_key :jobs, :members
  end
end
