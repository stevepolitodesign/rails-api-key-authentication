class Api::V1::PostsController < Api::V1::BaseController
  def index
    @posts = @user.posts
  end
end
