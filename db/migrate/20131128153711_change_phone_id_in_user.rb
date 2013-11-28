class ChangePhoneIdInUser < ActiveRecord::Migration
  def change
    change_column :users, :phoneID, :string
  end
end
