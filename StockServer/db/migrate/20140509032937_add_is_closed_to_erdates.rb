class AddIsClosedToErdates < ActiveRecord::Migration
  def change
    add_column :erdates, :is_closed, :integer, :default => 0
  end
end
