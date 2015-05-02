class AddUserToCooperative < ActiveRecord::Migration
  def change
    add_reference :users, :cooperatives, index: true
    add_foreign_key :users, :cooperatives
    add_column :users, :user_role, :integer, default: User::ROLES[:no_role]
  end
end
