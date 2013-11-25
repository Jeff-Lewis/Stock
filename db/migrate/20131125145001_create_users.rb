class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :phoneID
      t.integer :age
      t.string :interest
      t.integer :agility
      t.integer :strength
      t.integer :arithmatic
      t.integer :logic
      t.integer :literature
      t.integer :teamwork

      t.timestamps
    end
  end
end
