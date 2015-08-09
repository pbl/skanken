class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.text :comment
      t.references :user, index: true
      t.references :member, index: true
      t.references :activity, index: true

      t.timestamps null: false
    end
    add_foreign_key :jobs, :members
    add_foreign_key :jobs, :users
    add_foreign_key :jobs, :activities
  end
end