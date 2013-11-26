class ChangeStatusInTask < ActiveRecord::Migration
  def change
    change_column :tasks, :status, :float, :default => 0.0
  end
end
