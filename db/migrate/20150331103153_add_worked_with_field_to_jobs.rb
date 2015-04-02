class AddWorkedWithFieldToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :activity, :string
  end
end
