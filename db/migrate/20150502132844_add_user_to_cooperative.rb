class AddUserToCooperative < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: :no_role
  end
end