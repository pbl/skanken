class AddUserToCooperative < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: :no_role
    add_reference :users, :cooperative, index: true
    add_foreign_key :users, :cooperative
  end
end