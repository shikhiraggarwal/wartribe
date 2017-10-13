class Village < ApplicationRecord
	belongs_to :character
	belongs_to :world

	def self.create_first_village(character_id, world_id)
		village = Village.new
		village.name = "New Village"
    village.character_id = character_id
    village.world_id = world_id
    village.coords = get_valid_coords(true)
    village.data = {}
    village.save
    return village.id
	end

	def get_valid_coords(is_first_village, direction = nil, coords = nil)
		if direction && !coords
			if Map.check_direction_full(direction)
				return false
			end
		else
			direction = Map.get_least_populated_direction()
		end
		if coords
			if Map.validated_coordinates(coords)
				return false
			end
		else
			coords = Map.get_best_coordinate_location(direction)
		end
		return coords
	end
end
