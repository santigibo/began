class CommentsController < ApplicationController
  def create
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @comment = Comment.new(safe_params)
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to posts_path
    else
      render "posts/index"
    end
  end

  private

  def safe_params
    params.require(:comment).permit(:content)
  end
end
