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
      redirect_to admin_root_path
    else
      render :show
    end
  end
end
