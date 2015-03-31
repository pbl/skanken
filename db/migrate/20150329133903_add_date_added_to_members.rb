class AddDateAddedToMembers < ActiveRecord::Migration
  def change
    add_column :members, :dateAdded, :string
  end
end
