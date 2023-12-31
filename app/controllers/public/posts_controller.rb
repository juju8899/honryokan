class Public::PostsController < ApplicationController
  before_action :edit_authorize, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def search
    # 楽天APIを使用して書籍検索を行う
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end

  def search_tag
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿
    @posts = @tag.posts.all.page(params[:page]).per(5)
  end

  def search_title
    @word = params[:word]
    @posts = Post.looks(@word).page(params[:page]).per(5)
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
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @tag_list = @post.post_tags.joins(:tag).pluck('tags.name').join(',')
    @post_tags = @post.tags
    @user = @post.user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_id].split(',').map(&:strip)

    if @post.update(post_params)
      @post.save_tags(tag_list)
      redirect_to post_path(@post),notice: "変更を保存しました"
    else
      render "edit"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(current_user),notice: "削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :point, :tag_ids, :isbn)
  end

  def edit_authorize
    @post = Post.find(params[:id])
    user = @post.user
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
end
