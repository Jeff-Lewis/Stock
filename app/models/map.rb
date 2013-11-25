class Map < ActiveRecord::Base
  attr_accessible :name, :is_multi

  has_many :positions, dependent: :destroy
end
