require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup  do
    @user = User.new(email: "unique_email@example.com", password: "password")
  end 

  test "should be valid" do
    assert @user.valid?
  end

  test "set_private_api_key" do
    assert_nil @user.private_api_key
    @user.save
    assert_not_nil @user.private_api_key
    assert_not_nil @user.private_api_key_bidx
  end

  test "private_api_key should be unique" do
    @user.save
    @user_with_duplicate_private_api_key = User.new(email: "another_unique_email@example.com", password: "password", private_api_key: @user.private_api_key)
    assert_not @user_with_duplicate_private_api_key.valid?
  end

  test "should destroy associated requests" do
    flunk
  end
end
