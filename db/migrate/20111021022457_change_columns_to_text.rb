class ChangeColumnsToText < ActiveRecord::Migration
  def up
    change_column :parameters, :description, :text
  end

  def down
  end
end
