class Erdate < ActiveRecord::Base
  attr_accessible :confcall, :datetime, :estimate, :stock_id, :value

  belongs_to :stock
  has_and_belongs_to_many :users
end
