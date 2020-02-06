class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post
      flash[:notice] = "Post Created!"
    else
      redirect_back (fallback location: root_path)
      flash[:alert] = "Post creation failed"
    end
  end
  def show
    @post = Post.find(params[:id])
  end
  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to "/posts"
  end

  private
  def post_params
    params.require(:post).permit(:caption, :pic)
  end
end
