class Stock < ActiveRecord::Base
  attr_accessible :name, :symbol, :exchange_id

  has_one :popularity, dependent: :destroy
  has_one :detail, dependent: :destroy
  has_many :erdates, dependent: :destroy
  has_many :tweets, dependent: :destroy

  belongs_to :exchange

  has_and_belongs_to_many :users

  def nearestErdate
    #one week old at most
    datetime = DateTime.now - 57.days
    ers = erdates.where("datetime >= ?", datetime).order('datetime asc')
    if !ers.empty?
      ers.first
    end
  end
end
