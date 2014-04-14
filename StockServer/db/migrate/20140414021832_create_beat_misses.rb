class CreateBeatMisses < ActiveRecord::Migration
  def change
    create_table :beat_misses do |t|
      t.integer :erdate_id
      t.integer :user_id
      t.integer :beat

      t.timestamps
    end
  end
end
