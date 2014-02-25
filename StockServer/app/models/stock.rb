class Stock < ActiveRecord::Base
  attr_accessible :name, :symbol

  has_one :popularity, dependent: :destroy
  has_many :erdates, dependent: :destroy
end
