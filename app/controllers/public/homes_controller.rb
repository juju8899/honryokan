class Public::HomesController < ApplicationController
  def top
    @posts = Post.active_posts.page(params[:page]).per(10)
    @tag_list = Tag.all
  end

  def about
  end
end
