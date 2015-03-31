class AddCommentToMembers < ActiveRecord::Migration
  def change
    add_column :members, :comment, :string
  end
end
