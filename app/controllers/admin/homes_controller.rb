class Admin::HomesController < ApplicationController
  def top
    @users = User.limit(5)
  end
end
