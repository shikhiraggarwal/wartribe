class Village < ApplicationRecord
	belongs_to :character
	belongs_to :world
end
