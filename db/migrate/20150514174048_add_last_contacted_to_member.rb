class AddLastContactedToMember < ActiveRecord::Migration
  def change
  	add_column :members, :last_contacted, :string, default: "Never contacted"
  end
end
