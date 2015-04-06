class ChangeContactedsFieldName < ActiveRecord::Migration
  def change
    rename_column :contacteds, :for, :activity
  end

end
