class AddMobileToMembers < ActiveRecord::Migration
  def change
    add_column :members, :mobile, :string
  end
end
