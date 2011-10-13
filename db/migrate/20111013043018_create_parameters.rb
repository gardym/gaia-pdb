class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.string :description
      t.string :unit
      t.string :source
      t.string :expression
      t.timestamps
    end
  end
end
