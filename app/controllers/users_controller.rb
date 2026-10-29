class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    begin 
      if @user.save
        redirect_to @users, flash.now[:notice] = "User successfully registered!"
      else
        redirect_to @users, flash.now[:alert] = "Something went wrong. Please, try again!"
      end
    rescue ActiveRecord::RecordNotUnique
        @user.errors.add(:email, "has already been registered")
        render :new, status: :unprocessable_entity
    end
  end

  def destroy
    
  end

  private

  def set_user
    @user = User.find(params:[id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :job_position)
  end
end
