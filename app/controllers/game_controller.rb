class GameController < ApplicationApiController
  
	# device_id, email_id(optional), version, device_type = [android, ios]
  def init
  	# Create a player if not exist for that device id (y)
  	# Create a character and add the same character in a world that is 
  	#currently created and if full add another world
  	# Create an instance of WorldOpener library with params world_size, world_config_id and 
  	#create a world_config if no config available and then call start_game_world method
  	device_id = check_device_id(params[:device_id], params[:device_type])
  	if device_id
  		player = Player.find_by_device_id(device_id) # complete
  		world = Player.join_world(player)
  		json_response(player, :ok)
  	else
  		json_response("test unsuccessful response", :unprocessable_entity)
  	end
  end

  protected
  	def check_device_id(device_id, device_type)
  		if device_type == 'ios'
  			return device_id
  		else
  			return nil
  		end
  	end
end
