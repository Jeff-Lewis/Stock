class Detail < ActiveRecord::Base
  attr_accessible :avgVol, :divYield, :eps, :marketCap, :pe, :stock_id, :yearMax, :yearMin

  belongs_to :stock
end
