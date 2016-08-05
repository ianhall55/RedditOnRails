class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # if current_user
    #   flash.now[:errors] = ["Already logged in"]
    #   render :new
    # end
    @user = User.find_by_credentials(session_params[:username], session_params[:password])
    if @user
      login(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["404: User not found"]
      render :new
    end
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])
    logout(@user)
    render :new
  end



  def session_params
    params.require(:session).permit(:username, :password, :session_token)
  end


end
