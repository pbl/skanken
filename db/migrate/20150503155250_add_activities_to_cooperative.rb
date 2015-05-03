class AddActivitiesToCooperative < ActiveRecord::Migration
  def change
		add_column :cooperatives, :activities, :string, default: "" 
  end
end
