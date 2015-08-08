class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :mobile
      t.string :email
      t.string :activities
      t.string :comment
      t.string :date_of_birth
      t.datetime :last_contacted
      t.references :cooperative, index: true

      t.timestamps null: false
    end
    add_foreign_key :members, :cooperatives
  end
end