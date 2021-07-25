require "test_helper"

class RequestTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @request = @user.requests.build(method: :get, requestable_type: "Post")
  end

  test "should be valid" do
    assert @request.valid?
  end

  test "should have user" do
    @request.user = nil
    assert_not @request.valid?
  end

  test "should have requestable_type" do
    @request.requestable_type = nil
    assert_not @request.valid?
  end

  test "requestable_type should be constrained" do
    @request.requestable_type = "User"
    assert_not @request.valid?
  end

  test "should have method" do
    @request.method = nil
    assert_not @request.valid?
  end

end
