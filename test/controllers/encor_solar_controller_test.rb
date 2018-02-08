require 'test_helper'

class EncorSolarControllerTest < ActionDispatch::IntegrationTest
  test "should get locations" do
    get encor_solar_locations_url
    assert_response :success
  end

end
