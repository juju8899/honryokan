class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(is_status: false)
      sign_out @user
      flash[:notice] = "強制退会"
      redirect_to admin_user_path(@user)
    else
      render :show
    end
  end

  def active
    @user = User.find(params[:id])
    if @user.update(is_status: true)
      sign_out @user
      flash[:notice] = "有効化"
      redirect_to admin_user_path(@user)
    else
      render :show
    end
  end
end
