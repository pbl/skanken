class CreateContacteds < ActiveRecord::Migration
  def change
    create_table :contacteds do |t|
      t.date :date
      t.string :activity
      t.text :comment

      t.references :member, index: true

      t.timestamps null: false
    end
    add_foreign_key :contacteds, :members
  end
end