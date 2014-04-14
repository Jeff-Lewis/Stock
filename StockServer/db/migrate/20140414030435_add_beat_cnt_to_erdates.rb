class AddBeatCntToErdates < ActiveRecord::Migration
  def change
    add_column :erdates, :beat_cnt, :integer
    add_column :erdates, :miss_cnt, :integer
  end
end
