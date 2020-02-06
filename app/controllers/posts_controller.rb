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
      post = Post.find(params[:id])
    if current_user == post.user
      post.destroy
      redirect_to "/posts"
      flash[:notice] = "Post Destroyed"
    else
      redirect_back (fallback location: root_path)
      flash[:alert] = "Not authorized to delete post"
    end
  end
  def edit
    @post = Post.find(params[:id])
    if current_user != @post.user
      sign_out current_user
      redirect_to root_path
      flash[:notice] = "Unauthorized Request"
    end
  end
  def update
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.update(post_params)
      redirect_to "/posts/#{@post.id}/edit"
      flash[:notice] = "Edit Post"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "Not authorized to edit post"
    end
  end
  private
  def post_params
    params.require(:post).permit(:caption, :pic)
  end
end
