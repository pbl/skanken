class AddNbrContactedsAndJobsToMember < ActiveRecord::Migration
  def change
  	add_column :members, :nbr_jobs, :integer, default: 0
  	add_column :members, :nbr_contacteds, :integer, default: 0
  end
end
