class Stock < ActiveRecord::Base
  attr_accessible :name, :symbol, :exchange_id

  has_one :popularity, dependent: :destroy
  has_one :detail, dependent: :destroy
  has_many :erdates, dependent: :destroy
  has_many :tweets, dependent: :destroy

  belongs_to :exchange

  has_and_belongs_to_many :users
end
