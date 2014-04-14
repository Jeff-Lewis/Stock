class BeatMiss < ActiveRecord::Base
  attr_accessible :beat, :erdate_id, :user_id

  belongs_to :erdate
  belongs_to :user

  def beat?
    beat == 1
  end

  def beat!
    self.beat = 1
  end

  def miss?
    beat == -1
  end

  def miss!
    self.beat = -1
  end
end
