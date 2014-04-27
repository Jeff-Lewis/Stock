class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.belongs_to :user
      t.belongs_to :stock
      t.belongs_to :erdate

      t.timestamps
    end
  end
end
