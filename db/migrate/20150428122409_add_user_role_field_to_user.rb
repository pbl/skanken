class AddUserRoleFieldToUser < ActiveRecord::Migration
  def change
  	add_column :users, :user_role, :integer, default: User::ROLES[:no_role] 
  end

end
