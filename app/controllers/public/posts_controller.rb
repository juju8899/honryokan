class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def search
    # 楽天APIを使用して書籍検索を行う
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      tag_list = params[:post][:tag_id].split(',').map(&:strip)
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: "投稿しました"
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

  private

  def post_params
    params.require(:post).permit(:title, :point)
  end

end
