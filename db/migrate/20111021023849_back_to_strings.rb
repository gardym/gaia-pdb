class BackToStrings < ActiveRecord::Migration
  def up
    change_column :parameters, :description, :string, :limit => 1024
    change_column :parameters, :source, :string, :limit => 1024
  end

  def down
  end
end
