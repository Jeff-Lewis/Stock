class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :user_id
      t.integer :map_id
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
