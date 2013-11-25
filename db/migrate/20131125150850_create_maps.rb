class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :name
      t.integer :is_multi

      t.timestamps
    end
  end
end
