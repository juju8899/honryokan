class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @users = User.page(params[:page]).per(5)
  end
end
