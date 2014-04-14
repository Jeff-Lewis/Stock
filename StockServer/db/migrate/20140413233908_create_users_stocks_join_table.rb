class CreateUsersStocksJoinTable < ActiveRecord::Migration
  def change
    create_table :users_stocks do |t|
      t.integer :user_id
      t.integer :stock_id
    end

    add_index :users_stocks, [:user_id, :stock_id], unique: true
  end
end
