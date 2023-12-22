class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  def confirm
    @user = current_user
  end

  def withdrawal
    @user = current_user
    if @user.update(is_status: false)
      sign_out @user
      flash[:notice] = "退会しました"
      redirect_to root_path
    else
      render :confirm
    end
  end

  private

  def user_params
    params.require(:user).permit(:nick_name, :introduction, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    end
  end
end
