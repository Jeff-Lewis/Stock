class Erdate < ActiveRecord::Base
  attr_accessible :confcall, :datetime, :estimate, :stock_id, :value, :beat_cnt, :miss_cnt, :is_closed

  belongs_to :stock
  has_and_belongs_to_many :users
  has_many :beat_misses
  has_many :tweets

  def isClosed?
    return self.is_closed == 1
  end

  def close!
    self.is_closed = 1
    self.save!
  end

  def initBeatMissCnt
    if self.beat_cnt.nil?
      self.beat_cnt = 10 + rand(100)
      self.save!
    end

    if self.miss_cnt.nil?
      self.miss_cnt = 10 + rand(100)
      self.save!
    end
  end
end
