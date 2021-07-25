require "test_helper"

class Api::V1::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Using a fixture did not work. Intead, I needed to create a user
    @user_one = User.create(email: "#{SecureRandom.hex}@example.com", password: "password")
    @user_two = User.create(email: "#{SecureRandom.hex}@example.com", password: "password")
    @user_one_post = @user_one.reload.posts.create(title: "User One Post", body: "Body")
    @user_two_post = @user_two.reload.posts.create(title: "User One Post", body: "Body")
  end

  class Authenticated < Api::V1::PostsControllerTest
    test "should get posts" do
      get api_v1_posts_path, headers: { "Authorization": "Token token=#{@user_one.private_api_key}" }
      assert_equal "application/json; charset=utf-8", @response.content_type
      assert_match  @user_one_post.title, @response.body
      assert_response :ok
    end

    test "should get post" do
      get api_v1_post_path(@user_one_post), headers: { "Authorization": "Token token=#{@user_one.private_api_key}" }
      assert_equal "application/json; charset=utf-8", @response.content_type
      assert_match  @user_one_post.title, @response.body
      assert_response :ok
    end

    test "should handle 404" do
      get api_v1_post_path("does_not_exis"), headers: { "Authorization": "Token token=#{@user_one.private_api_key}" }
      assert_equal "application/json; charset=utf-8", @response.content_type
      assert_response :not_found
    end
  end

  class Unauthorized < Api::V1::PostsControllerTest
    test "should not get posts" do
      get api_v1_posts_path
      assert_response :unauthorized
    end

    test "should not load another's post" do
      get api_v1_post_path(@user_two_post), headers: { "Authorization": "Token token=#{@user_one.private_api_key}" }
      assert_equal "application/json; charset=utf-8", @response.content_type
      assert_response :unauthorized
    end
  end

end
