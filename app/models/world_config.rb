class WorldConfig < ApplicationRecord
	has_many :worlds

	def self.create_new_config
		world_config = WorldConfig.new
		world_config.name = "General"
		world_config.data = "{}"
		world_new_config = world_config.save
		if world_new_config
			return world_config.id
		else
			return false
		end
	end
end
