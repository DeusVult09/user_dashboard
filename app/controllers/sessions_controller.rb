class SessionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def new
  end

  def create
    return user_login if user_authenticated? && @user.active?
    return login_reject("Your account is blocked") if @user.blocked?
    login_reject
  end

  def destroy
    reset_session
    redirect_to new_session_path, notice: "User logged out", status: :see_other
  end

  private 

  def set_user
    @user = User.find_by(email: params[:email])
  end

  def user_authenticated?
    @user&.authenticate(params[:password])
  end

  def user_login
    reset_session
    session[:user_id] = @user.id 
    @user.update_columns(last_login_at: Time.current)
    redirect_to root_path, notice: "Welcome to the User Dashboard"
  end

  def login_reject(message = "Email or password is incorrect")
    flash.now[:alert] = message
    render :new, status: :unprocessable_entity
  end
end   


