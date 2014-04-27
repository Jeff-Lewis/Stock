class Tweet < ActiveRecord::Base
  attr_accessible :content, :stockId, :userId, :erdateId

  belongs_to :user, dependent: :destroy
  belongs_to :stock, dependent: :destroy
  belongs_to :erdate, dependent: :destroy
end
