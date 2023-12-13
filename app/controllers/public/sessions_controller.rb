# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # ログイン前ユーザーステータスを確認
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private
  # アクティブであるかを判断するメソッド
  def user_state
    #入力されたemailからアカウントを1件取得
    user = User.find_by(nick_name: params[:user][:nick_name])
    #アカウントを取得できなかった場合、このメソッドを終了
    return if user.nil?
    #取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了
    return unless user.valid_password?(params[:user][:password])
    #退会済みのユーザーに対してサインアップ画面へ遷移
    if user.is_status
      create
    else
      flash[:notice] = "アカウントは退会済みです。"
      redirect_to new_user_registration_path
    end
  end
end
