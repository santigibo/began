class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.new
    @comment = Comment.new

    @forum = true
  end

  def create
    @posts = Post.all
    @comment = Comment.new
    @post = Post.new(safe_params)
    @post.user = current_user

    if @post.save
      redirect_to posts_path
    else
      render :index
    end
  end

  def update
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def safe_params
    params.require(:post).permit(:content)
  end

end
