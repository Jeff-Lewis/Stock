class Task < ActiveRecord::Base
  attr_accessible :level, :category, :map_id, :name, :status, :is_multi, :x, :y
end
