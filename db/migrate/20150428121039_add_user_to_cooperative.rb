class AddUserToCooperative < ActiveRecord::Migration
  def change
  	add_reference :users, :cooperatives, index: true
    add_foreign_key :users, :cooperatives
  end
end
