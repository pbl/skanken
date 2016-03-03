class AddCommentToContacteds < ActiveRecord::Migration
  def change
    add_column :contacteds, :comment, :text, default: ""
  end
end
