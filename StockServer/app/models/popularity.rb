class Popularity < ActiveRecord::Base
  attr_accessible :stock_id, :total, :trend
  belongs_to :stock
  validates_presence_of :stock_id
  validates :total, :numericality => { :greater_than_or_equal_to => 0}
end
