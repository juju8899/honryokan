class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments
  end

  def destroy
    comment = Comment.find(params[:id])
    user_id = comment.user_id
    comment.destroy
    redirect_to admin_user_comments_path(user_id), notice: "コメントを削除しました"
  end
end
