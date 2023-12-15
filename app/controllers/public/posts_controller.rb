class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def search
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
      # redirect_to new_post_path(title: @books.first.title, author: @books.first.author, summary: @books.first.summary, image_url: @books.first.medium_image_url)
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id =current_user.id
    if @post.save
      redirect_to post_path(@post),notice: "投稿しました"
    else
      render :new
    end
  end

  def index
  end

  def show
  end

end
