class AddExchangeIdToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :exchange_id, :integer
  end
end
