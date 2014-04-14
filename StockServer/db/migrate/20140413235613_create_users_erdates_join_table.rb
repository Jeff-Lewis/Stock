class CreateUsersErdatesJoinTable < ActiveRecord::Migration
  def change
    create_table :users_erdates do |t|
      t.integer :user_id
      t.integer :erdate_id
    end

    add_index :users_erdates, [:user_id, :erdate_id], unique: true
  end
end
