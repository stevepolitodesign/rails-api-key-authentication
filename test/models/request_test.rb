require "test_helper"

class RequestTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @post = posts(:one)
    @request = @user.requests.build(method: :get, requestable: @post)
  end

  test "should be valid" do
    assert @request.valid?
  end

  test "should have user" do
    @request.user = nil
    assert_not @request.valid?
  end

  test "should have requestable" do
    @request.requestable = nil
    assert_not @request.valid?
  end

  test "should have method" do
    @request.method = nil
    assert_not @request.valid?
  end

end
