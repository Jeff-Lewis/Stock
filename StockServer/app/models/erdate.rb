class Erdate < ActiveRecord::Base
  attr_accessible :confcall, :datetime, :estimate, :stock_id, :value, :beat_cnt, :miss_cnt

  belongs_to :stock
  has_and_belongs_to_many :users
  has_many :beat_misses
  has_many :tweets
end
