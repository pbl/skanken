class RemoveNbrJobsFromMembers < ActiveRecord::Migration
  def change
    remove_column :members, :nbr_jobs, :integer
  end
end
