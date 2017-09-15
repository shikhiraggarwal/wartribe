class WorldOpener
	
	def initialize(world_size, world_config_id)
		@open_worlds = WorldOpener.get_open_list
		@world_size = world_size
		@world_config_id = world_config_id
	end

	# Sample OpenWorldList data = {1 => {'name' => 'My World', 'population' => '2000', 'map' => 1, 'wc' => 1},
	# 2 => {'name' => 'My World2', 'population' => '1000', 'map' => 2, 'wc' => 2},
	# 3 => {'name' => 'My World3', 'population' => '2500', 'map' => 3, 'wc' => 5},
	#	}
	def self.get_open_list
	  list = $redis.get(WorldOpener.open_list_key)
	  list = list ? JSON.parse(list) : {}
	  return list
	end

	def self.auto_open_list_key
    "OpenWorldList"
  end
  
	def start_game_world
		world = World.new
		map_id = create_map
		if map_id == false
			return false
		end
		world.map_id = map_id
		world.world_config_id = @world_config_id
		world.final = "false"
		world.data = "{}"
		new_world = world.save
		if new_world
			return world.id
		else
			return false
		end
	end
  
	def create_map
		map_size = @world_size
		map_fields = {}
		for x in (-1*map_size..map_size)
			fields = *(1..200)
			for y in (-1*map_size..map_size)
				field_type = fields.sample
				map_fields["#{x},#{y}"] = field_type
				fields.delete(field_type)
			end
		end
		map = Map.new
		map.data = map_fields.to_s
		map.size = map_size
		new_map = map.save
		if new_map
			return map.id
		else
			return false
		end
	end

end
