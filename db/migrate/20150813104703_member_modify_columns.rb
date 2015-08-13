class MemberModifyColumns < ActiveRecord::Migration
  def change
    remove_column :members, :comment
  end
end
