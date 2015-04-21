class EditMemberFields < ActiveRecord::Migration
  def change
  	rename_column :members, :work, :activities
  	
  	remove_column :members, :term
  	remove_column :members, :workCard
  end
end
