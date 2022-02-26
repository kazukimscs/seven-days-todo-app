class UsersController < ApplicationController
  skip_before_action :login_required

  def new
    @user = User.new(flash[:user])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to homes_path
    else
      redirect_back fallback_location: root_path, flash: {
        user: user,
        error_messages: user.errors.full_messages
      }
      #flash[:user] = user
      #flash[:error_messages] = user.errors.full_messages
      #redirect_back fallback_location: 'http://localhost'
    end
  end

  def me
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
