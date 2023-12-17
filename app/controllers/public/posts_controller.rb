class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def search
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
      # Rails.cache.write('selected_book_info', {
      #   title: @books.first.title,
      #   author: @books.first.author,
      #   summary: @books.first.item_caption,
      #   image_url: @books.first.medium_image_url
      # })
      # redirect_to new_post_path
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id =current_user.id
    @tag_list = params[:post][:name].split('、')
    if @post.save
      @post.save_tags(tag_list)
      redirect_to post_path(@post),notice: "投稿しました"
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

end
