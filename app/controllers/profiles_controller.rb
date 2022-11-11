class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  def index
    @profiles = Profile.all

    if @profiles
      render json: { status: 200, data: @profiles }
    else
      render json: { status: 500, data: "Falha ao buscar usuários" }
    end
  end
  
  def show
    @profile = Profile.where(id: params[:id]).first

    if @profile.present?
      render json: { status: 200, data: @profile }
    else
      render json: { status: 404, data: "Perfil não encontrado" }
    end
  end
  
  def create
    @profile = Profile.create(profile_params)

    if @profile.save
      render json: { status: 200, data: @profile }
    else 
      render json: { status: 500, data: "Falha ao cadastrar perfil" }
    end
  end
  
  def update
    @profile = Profile.where(id: params[:id]).first
    
    if @profile.present?
      @profile.update(profile_params)
      
      if @profile.save
        render json: { status: 200, data: @profile }
      else 
        render json: { status: 500, data: "Falha ao editar perfil" }
      end
    else
      render json: { status: 404, data: "Perfil não encontrado" }
    end
  end
  
  def destroy
    @profile = Profile.where(id: params[:id]).first

    if @profile.present?
      @profile.destroy
      
      if @profile.destroyed?
        render json: { status: 204, data: nil }
      else 
        render json: { status: 500, data: "Falha ao remover perfil" }
      end
    else
      render json: { status: 404, data: "Perfil não encontraedo" }
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:_type, :user_id)
    end
end
