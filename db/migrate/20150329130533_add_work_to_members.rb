class AddWorkToMembers < ActiveRecord::Migration
  def change
    add_column :members, :work, :string
  end
end
