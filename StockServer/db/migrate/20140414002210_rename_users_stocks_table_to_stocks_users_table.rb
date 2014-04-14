class RenameUsersStocksTableToStocksUsersTable < ActiveRecord::Migration
  def change
    rename_table :users_stocks, :stocks_users
  end
end
