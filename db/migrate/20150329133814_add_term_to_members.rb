class AddTermToMembers < ActiveRecord::Migration
  def change
    add_column :members, :term, :string
  end
end
