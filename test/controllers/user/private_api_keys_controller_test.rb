require "test_helper"

class User::PrivateApiKeysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "update" do
    original_private_api_key = @user.private_api_key
    sign_in @user
    put user_private_api_keys_path
    assert_not_equal original_private_api_key, @user.reload.private_api_key
  end
end
