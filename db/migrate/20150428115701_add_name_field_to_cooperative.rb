class AddNameFieldToCooperative < ActiveRecord::Migration
  def change
    add_column :cooperatives, :name, :string
  end
end
