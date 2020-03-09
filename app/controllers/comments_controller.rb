class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(safe_params)
    @comment.post = post
    @comment.user = current_user
    @comment.save
  end

  private

  def safe_params
    params.require(:comment).permit(:content)
  end
end
