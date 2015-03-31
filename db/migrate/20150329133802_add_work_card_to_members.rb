class AddWorkCardToMembers < ActiveRecord::Migration
  def change
    add_column :members, :workCard, :string
  end
end
