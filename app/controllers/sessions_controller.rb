class SessionsController < ApplicationController
  before_action :require_logged_in, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    user =
      User.find_by_credentials(
        params[:user][:username],
        params[:user][:password],
      )
    @user = User.new(user_params)

    if user
      login!(user)
      redirect_to poems_url
    else
      flash[:errors] = ['Invalid username or password']
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
