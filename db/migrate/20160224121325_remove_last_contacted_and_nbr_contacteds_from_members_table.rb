class RemoveLastContactedAndNbrContactedsFromMembersTable < ActiveRecord::Migration
  def change
    remove_column :members, :nbr_contacteds, :integer
    remove_column :members, :last_contacted, :datetime
  end
end
