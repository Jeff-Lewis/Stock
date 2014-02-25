class CreatePopularities < ActiveRecord::Migration
  def change
    create_table :popularities do |t|
      t.integer :stock_id
      t.integer :total, :default => 0
      t.integer :trend, :default => 0

      t.timestamps
    end
  end
end
