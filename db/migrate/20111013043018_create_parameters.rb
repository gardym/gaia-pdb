class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.string :description, :limit => 1024
      t.string :unit, :limit => 1024
      t.string :source
      t.string :expression
      t.timestamps
    end
  end
end
