class Public::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post), notice: "コメントを投稿しました"
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id]), notice: "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end