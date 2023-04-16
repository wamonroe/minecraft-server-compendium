require "test_helper"

class ServersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:confirmed_user)
    @server = servers(:server_1)
    sign_in @user
  end

  test "should get index" do
    get servers_url
    assert_response :success
  end

  test "should get new" do
    get new_server_url
    assert_response :success
  end

  test "should create server" do
    assert_difference("Server.count") do
      post servers_url, params: {
        server: {name: "New server", hostname: "new_minecraft.example.com"}
      }
    end

    server = Server.find_by(name: "New server")
    assert_not_nil server

    unless server.nil?
      assert_redirected_to server_url(server)
      assert_equal @user, server.user
    end
  end

  test "should show server" do
    get server_url(@server)
    assert_response :success
  end

  test "should get edit" do
    get edit_server_url(@server)
    assert_response :success
  end

  test "should update server" do
    patch server_url(@server), params: {server: {name: "New server name"}}
    assert_redirected_to server_url(@server)
  end

  test "should destroy server" do
    assert_difference("Server.count", -1) do
      delete server_url(@server)
    end

    assert_redirected_to servers_url
  end
end
