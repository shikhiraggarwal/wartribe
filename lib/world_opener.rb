class WorldOpener
	
	def initialize
		@open_worlds = WorldOpener.get_open_list
	end

	def get_open_list
	  list = $redis.get(open_list_key)
	  list = list ? JSON.parse(list) : {}
	  return list
	end

	def self.auto_open_list_key
    "OpenWorldList"
  end
  
	def start_game_world
		
	end

end