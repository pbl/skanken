class RemoveJobNumberAndContactedNumberToMembers < ActiveRecord::Migration
  def change
  	remove_column :members, :job_number
  	remove_column :members, :contacted_number
  end
end
