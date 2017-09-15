class Character < ApplicationRecord
	belongs_to :player
	belongs_to :world
	
	has_many :villages
	has_many :reports
end
