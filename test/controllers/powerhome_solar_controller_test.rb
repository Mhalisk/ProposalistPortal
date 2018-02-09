require 'test_helper'

class PowerhomeSolarControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get powerhome_solar_home_url
    assert_response :success
  end

end
