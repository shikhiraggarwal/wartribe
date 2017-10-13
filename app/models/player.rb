class Player < ApplicationRecord
	has_many :characters
	has_many :player_mappings

	def self.find_by_device_id(device_id)
		mapping = PlayerMapping.where("device_id = ?", device_id).first
		if mapping.blank?
			mapping = PlayerMapping.new
			player = Player.new
      player.email_verified = false
      player.is_deleted = false
      player.device_id = device_id
      player.data = "{}"
      player.save
      mapping.device_id = device_id
      mapping.user_id = player.id
      mapping.save
    else
    	player = Player.where("id = ? and is_deleted = 0", mapping.user_id).first
		end

		return player
	end

	def self.join_world(player)
		world_id = World.get_joinable_world
		if !world_id
			return false
		end
		character_id = Character.create_world_character(world_id, player.id)
		if character_id
			Village.create_first_village(character_id, world_id)
		else
			return false
		end
	end

	# protected
	# 	def playername
	# 		timestamp = Time.now.utc.to_i
	# 		"LORD#{timestamp}"
	# 	end
end
