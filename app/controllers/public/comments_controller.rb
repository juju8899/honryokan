class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      redirect_to post_path(@post), notice: "コメントを投稿しました"
    else
      @tag_list = @post.post_tags.joins(:tag).pluck('tags.name').join(',')
      @post_tags = @post.tags
      @user = @post.user
      render "public/posts/show"
    end
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
