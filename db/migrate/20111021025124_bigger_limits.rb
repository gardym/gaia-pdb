class BiggerLimits < ActiveRecord::Migration
  def up
    change_column :parameters, :description, :string, :limit => 10000
    change_column :parameters, :unit, :string, :limit => 1000
    change_column :parameters, :source, :string, :limit => 10000
  end

  def down
  end
end
