class Exchange < ActiveRecord::Base
  attr_accessible :name

  has_many :stocks

  def usStock?
    self.name.upcase == "nyse".upcase || self.name.upcase == "NasdaqNM".upcase
  end
end
