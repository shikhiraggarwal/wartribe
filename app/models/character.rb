class Character < ApplicationRecord
	belongs_to :player
	belongs_to :world
	
	has_many :villages
	has_many :reports

	def self.create_world_character(world_id, player_id)
		character = Character.new
		character.player_id = player_id
		character.world_id = world_id
		data = {:tribe_changed => false, :login_changed => false}
		character.data = data.to_json
		character.tribe = TROOP_CONFIG["troops"].keys[0]
		character.save
		return character.id
	end
end
