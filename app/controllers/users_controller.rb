class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.create(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.username}!"
      redirect_to root_path
    else
      render :new
    end
  end

  def login_form
  end

  def login
    location_cookie = {  }
    location_cookie[:location] = params[:location]
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}!"
      cookies.signed.permanent[:location] = params[:location]

      if user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to root_path
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end