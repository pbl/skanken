class CreateCooperatives < ActiveRecord::Migration
  def change
    create_table :cooperatives do |t|

      t.timestamps null: false
    end
  end
end
