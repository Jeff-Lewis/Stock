class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.integer :stock_id
      t.float :yearMin
      t.float :yearMax
      t.float :avgVol
      t.float :marketCap
      t.float :pe
      t.float :eps
      t.float :divYield

      t.timestamps
    end
  end
end
