class MakingEveryFieldMassive < ActiveRecord::Migration
  def up
    change_column :parameters, :expression, :string, :limit => 1000
  end

  def down
  end
end
