class AddColumncToMembers < ActiveRecord::Migration
  def change
    add_column :members, :personId, :string
  end
end
