class Api::V1::PostsController < Api::V1::BaseController
  def index
    # TODO: Scope to the user
    @posts = Post.all
  end
end
