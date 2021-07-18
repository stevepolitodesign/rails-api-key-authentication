require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @post = @user.posts.build(title: "Title", body: "Body")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "should have title" do
    @post.title = nil
    assert_not @post.valid?
  end

  test "should have body" do
    @post.body = nil
    assert_not @post.valid?
  end  
end
