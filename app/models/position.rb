class Position < ActiveRecord::Base
  attr_accessible :map_id, :user_id, :x, :y

  belongs_to :user
  belongs_to :map
end
