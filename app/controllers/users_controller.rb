class UsersController < ApplicationController

  def new
  end

  # def show
  #   @user = User.find_by(session_token: session[:session_token])
  # end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.id = @user.id
      login(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:username, :password, :session_token)
  end

end
