class Admin::IndexController < Admin::ApplicationController
  def index
  	@map = Map.find(4)
  	@data = eval(@map.data)
  end
end
