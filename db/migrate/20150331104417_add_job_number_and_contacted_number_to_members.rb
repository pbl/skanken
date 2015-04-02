class AddJobNumberAndContactedNumberToMembers < ActiveRecord::Migration
  def change
	  add_column :members, :job_number, :integer
	  add_column :members, :contacted_number, :integer
  end
end
