class RenameUsersErdatesTableToErdatesUsersTable < ActiveRecord::Migration
  def change
    rename_table :users_erdates, :erdates_users
  end
end
