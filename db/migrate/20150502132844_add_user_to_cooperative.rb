class AddUserToCooperative < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: :no_role
    add_foreign_key :users, :cooperatives
  end
end