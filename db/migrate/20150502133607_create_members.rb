class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
    	t.string :name
    	t.string :mobile
    	t.string :email
    	t.string :personId
    	t.string :activities
    	t.string :comment
    	t.string :dateAdded

    	t.references :cooperative, index: true
 
    	t.timestamps null: false
  	end
  	add_foreign_key :members, :cooperatives
  end
end