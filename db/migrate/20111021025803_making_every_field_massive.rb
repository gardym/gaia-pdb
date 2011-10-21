class MakingEveryFieldMassive < ActiveRecord::Migration
  def up
    change_column :parameters, :expression, :string, :limit => 10000
  end

  def down
  end
end
