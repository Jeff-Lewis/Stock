class Exchange < ActiveRecord::Base
  attr_accessible :name

  has_many :stocks
end
