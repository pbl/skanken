class AddCommentToContacteds < ActiveRecord::Migration
  def change
    add_column :contacteds, :comment, :text
  end
end
