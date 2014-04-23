class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      t.string :username, :default => "Too lazy to have a name"
      t.integer :beat, :default => 0
      t.integer :miss, :default => 0
      t.integer :success, :default => 0
      t.integer :failure, :default => 0
      t.integer :rank, :default => 0
      t.integer :bullism, :default => 1

      t.timestamps
    end
  end
end
