class CreateErdates < ActiveRecord::Migration
  def change
    create_table :erdates do |t|
      t.integer :stock_id
      t.timestamp :datetime
      t.float :estimate, :default => 0
      t.float :value, :default => 0
      t.string :confcall

      t.timestamps
    end
  end
end
