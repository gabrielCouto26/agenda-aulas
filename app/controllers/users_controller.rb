class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.create(user_params)

    if @user.save
      render json: { status: 200, user: @user }
    else 
      render json: { status: 500, user: nil }
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end
  
  def destroy
    User.find([params[:id]]).destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :birth_date)
    end
end
