class ChangeColumnsToText < ActiveRecord::Migration
  def up
    change_column :parameters, :description, :text
    change_column :parameters, :source, :text
  end

  def down
    change_column :parameters, :description, :string
    change_column :parameters, :source, :string
  end
end
