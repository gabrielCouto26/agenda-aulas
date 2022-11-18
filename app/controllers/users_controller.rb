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
    @user = User.where(id: params[:id]).first

    if @user.present?
      render json: { status: 200, data: @user }
    else
      render json: { status: 404, data: "Usuário não encontrado" }
    end
  end
  
  def create
    user = User.where(email: user_params[:email]).first
    if user.present?
      render json: { status: 401, data: "Email já cadastrado" }
    else
      @user = User.create(user_params)
      @profile = Profile.create(_type: profile_params[:_type], user_id: @user.id)

      if @user.save and @profile.save
        render json: { status: 200, data: @user }
      else 
        render json: { status: 500, data: "Falha ao cadastrar usuário" }
      end
    end
  end
  
  def update
    @user = User.where(id: params[:id]).first
    
    if @user.present?
      @user.update(user_params)
      
      if @user.save
        render json: { status: 200, data: @user }
      else 
        render json: { status: 500, data: "Falha ao editar usuário" }
      end
    else
      render json: { status: 404, data: "Usuário não encontrado" }
    end
  end
  
  def destroy
    @user = User.where(id: params[:id]).first

    if @user.present?
      @user.destroy
      
      if @user.destroyed?
        render json: { status: 204, data: nil }
      else 
        render json: { status: 500, data: "Falha ao remover usuário" }
      end
    else
      render json: { status: 404, data: "Usuário não encontrado" }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :birth_date)
    end

    def profile_params
      params.require(:profile).permit(:_type)
    end
end
