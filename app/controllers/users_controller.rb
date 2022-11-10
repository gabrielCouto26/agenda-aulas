class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  def index
    @users = User.all

    if @users
      render json: { status: 200, data: @users }
    else
      render json: { status: 500, data: "Falha ao buscar usuários" }
    end
  end
  
  def show
    @user = User.where(id: params[:id])

    if @user.any?
      render json: { status: 200, data: @user.first }
    else
      render json: { status: 404, data: "Usuário não encontrado" }
    end
  end
  
  def create
    @user = User.create(user_params)

    if @user.save
      render json: { status: 200, data: @user }
    else 
      render json: { status: 500, data: "Falha ao cadastrar usuário" }
    end
  end
  
  def update
    @user = User.where(id: params[:id])
    
    if @user.any?
      @user.first.update(user_params)
      
      if @user.first.save
        render json: { status: 200, data: @user.first }
      else 
        render json: { status: 500, data: "Falha ao editar usuário" }
      end
    else
      render json: { status: 404, data: "Usuário não encontraedo" }
    end
  end
  
  def destroy
    @user = User.where(id: params[:id])

    if @user.any?
      @user.first.destroy
      
      if @user.first.destroyed?
        render json: { status: 204, data: nil }
      else 
        render json: { status: 500, data: "Falha ao remover usuário" }
      end
    else
      render json: { status: 404, data: "Usuário não encontraedo" }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :birth_date)
    end
end
