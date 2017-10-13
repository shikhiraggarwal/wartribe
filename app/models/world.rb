class World < ApplicationRecord
	belongs_to :world_config
	belongs_to :map

	def self.get_joinable_world
		open_worlds = World.get_open_list
		# open_worlds = JSON.parse(open_worlds)
		if !open_worlds.blank?
			last_open_world = open_worlds.to_a.last
			joinable = World.check_joinable(last_open_world[0], last_open_world[1]["population"])
			if joinable
				return last_open_world[0]
			end
		end
		world_id = World.start_game_world(50, 1)
		if world_id
			return world_id
		else
			return false
		end
	end

	def self.check_joinable(world_id, population)
		world = World.find(world_id)
		if world.created_at.to_i > (Time.now - 25.days).to_i && (World.get_population(world_id) < population)
			return true
		end
		return false
	end

	# Logic to be written to fetch the population of a world
	def self.get_population(world_id)
		characters = Character.where("world_id = ?", world_id).count
		return characters
	end

	#=========================================================
	def self.world_creator_data_setter(world_size, world_config_id)
		@open_worlds = World.get_open_list
		@world_size = world_size
		@world_config_id = world_config_id
	end

	# Sample OpenWorldList data = '{"1": {"name": "My World", "population": 2000, "map": 1, "wc": 1},"2": {"name": "My World2", "population": 1000, "map": 2, "wc": 2},"3": {"name": "My World3", "population": 2500, "map": 3, "wc": 5}}'
	def self.get_open_list
	  list = $redis.get(World.open_list_key)
	  list = list ? JSON.parse(list) : {}
	  return list
	end
	def self.set_open_list(json_data)
	  status = $redis.set(World.open_list_key, json_data)
	  return status
	end

	def self.open_list_key
    "OpenWorldList"
  end
  
	def self.start_game_world(world_size, world_config_id)
		
		World.world_creator_data_setter(world_size, world_config_id)
		world = World.new
		map_id = World.create_map
		if map_id == false
			return false
		end
		world.map_id = map_id
		world.world_config_id = @world_config_id
		world.final = "false"
		world.data = "{}"
		new_world = world.save
		if new_world
			World.add_to_open_list(world)
			return world.id
		else
			return false
		end
	end
  
	def self.create_map
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

	def self.add_to_open_list(world)
		worlds = @open_worlds
		#{"name": "My World", "population": 2000, "map": 1, "wc": 1}
		size = @world_size.to_i
		population = size * size * 0.4
		world_details = {"name" => world.name, "population" => population, "map" => world.map_id, "wc" => world.world_config_id}
		worlds["#{world.id}"] = world_details
		world_json = worlds.to_json.to_s
		status = World.set_open_list(world_json)
	end


end
