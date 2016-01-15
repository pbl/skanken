class CreateUserMembers < ActiveRecord::Migration
  def change
    create_table :user_members do |t|
      t.belongs_to :member, index: true
      t.belongs_to :user, index: true
      t.text :comment, default: ""
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
