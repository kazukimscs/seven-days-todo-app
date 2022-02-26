class SessionsController < ApplicationController
  skip_before_action :login_required

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to homes_path
    else
      flash[:login_failed] = "ログインできませんでした。ユーザー名、パスワードを正しく入力してください。"
      render 'top/index'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end