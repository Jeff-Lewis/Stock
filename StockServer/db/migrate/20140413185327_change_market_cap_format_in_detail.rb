class ChangeMarketCapFormatInDetail < ActiveRecord::Migration
  def up
    change_column :details, :marketCap, :string
  end

  def down
    change_column :details, :marketCap, :float
  end
end
