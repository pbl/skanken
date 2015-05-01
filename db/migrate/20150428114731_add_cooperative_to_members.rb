class AddCooperativeToMembers < ActiveRecord::Migration
  def change
    add_reference :members, :cooperatives, index: true
    add_foreign_key :members, :cooperatives
  end
end
