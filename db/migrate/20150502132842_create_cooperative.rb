class CreateCooperative < ActiveRecord::Migration
  def change
    create_table :cooperatives do |t|
    	t.string :name

    	t.timestamps null: false
    end
  end
end
