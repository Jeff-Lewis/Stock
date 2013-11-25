class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :is_multi
      t.integer :level
      t.integer :map_id
      t.integer :status
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
