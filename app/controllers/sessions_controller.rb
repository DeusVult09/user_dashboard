class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(:email, params[:email])

    if @user && @user.authenticate(params[:password])
      reset_session
      session[:user_id] = user.id 

      @user.update_column(last_login_at: Time.current)
      redirect_to root_path, notice: "You successfully logged in"
    else
      flash.now[:alert] = "Email or password is incorrect"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path, notice: "You successfully logged out", status: :see_other
  end

end
