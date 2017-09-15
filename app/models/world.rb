class World < ApplicationRecord
	belongs_to :world_config
	belongs_to :map
end
