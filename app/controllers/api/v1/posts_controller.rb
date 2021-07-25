class Api::V1::PostsController < Api::V1::BaseController
  before_action :set_post, only: [:show] 
  before_action :authorize_post, only: [:show]

  def index
    @posts = @user.posts
  end

  def show
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def authorize_post
      render json: { message: "Unauthorized" }, status: :unauthorized unless @user == @post.user
    end
end
