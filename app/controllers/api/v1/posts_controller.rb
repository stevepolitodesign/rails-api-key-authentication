class Api::V1::PostsController < Api::V1::BaseController
  def index
    @posts = @user.posts
  end

  def show
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end
end
