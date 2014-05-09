class Erdate < ActiveRecord::Base
  attr_accessible :confcall, :datetime, :estimate, :stock_id, :value, :beat_cnt, :miss_cnt, :is_closed

  belongs_to :stock
  has_and_belongs_to_many :users
  has_many :beat_misses
  has_many :tweets

  def isClosed?
    return is_closed == 1
  end

  def close!
    is_closed = 1
    this.save()
  end

  def initialize!
    if beat_cnt.nil?
      beat_cnt = 10 + rand(100)
      this.save()
    end

    if miss_cnt.nil?
      miss_cnt = 10 + rand(100)
      this.save()
    end
  end
end
