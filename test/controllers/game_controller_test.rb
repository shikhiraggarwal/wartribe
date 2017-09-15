require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get init" do
    get game_init_url
    assert_response :success
  end

end
