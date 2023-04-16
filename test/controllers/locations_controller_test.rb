require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:confirmed_user)
    @server = servers(:server_1)
    @location = locations(:server_1_spawn)
    sign_in @user
  end

  test "should get new" do
    get new_location_url(server_id: @server.id)
    assert_response :success
  end

  test "should create location" do
    assert_difference("Location.count") do
      post locations_url, params: {
        location: {name: "New location", x: 55, y: 55, z: 55, server_id: @server.id}
      }
    end

    location = Location.find_by(name: "New location")
    assert_not_nil location

    unless location.nil?
      assert_redirected_to server_url(location.server)
      assert_equal @user, location.user
    end
  end

  test "should get edit" do
    get edit_location_url(@location)
    assert_response :success
  end

  test "should update location" do
    patch location_url(@location), params: {location: {name: "New location name"}}
    assert_redirected_to server_url(@location.server)
  end

  test "should destroy location" do
    assert_difference("Location.count", -1) do
      delete location_url(@location)
    end

    assert_redirected_to server_url(@location.server)
  end
end
