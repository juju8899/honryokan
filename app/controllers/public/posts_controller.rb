class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def search
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
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
