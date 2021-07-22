require "test_helper"

class Api::V1::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Using a fixture did not work. Intead, I needed to create a user
    @user = User.create(email: "unique_email@example.com", password: "password")
  end

  class Authenticated < Api::V1::PostsControllerTest
    test "should get posts" do
      get api_v1_posts_path, headers: { "Authorization": "Token token=#{@user.private_api_key}" }
      assert_response :ok
    end
  end

  class Unauthorized < Api::V1::PostsControllerTest
    test "should not get posts" do
      get api_v1_posts_path
      assert_response :unauthorized
    end
  end

end
