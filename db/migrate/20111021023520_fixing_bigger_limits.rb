class FixingBiggerLimits < ActiveRecord::Migration
  def up
    change_column :parameters, :description, :text, :limit => 1024
    change_column :parameters, :source, :text, :limit => 1024
  end

  def down
  end
end
