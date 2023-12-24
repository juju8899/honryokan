class Admin::HomesController < ApplicationController
  def top
    @users = User.page(params[:page]).per(5)
  end
end
