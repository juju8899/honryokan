class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(_params)
      flash[:notice] = "変更を保存しました"
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end
end
