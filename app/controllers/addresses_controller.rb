class AddressesController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  def index
    @addresses = Address.all

    if @addresses
      render json: { status: 200, data: @addresses }
    else
      render json: { status: 500, data: "Falha ao buscar endereços" }
    end
  end
  
  def show
    @address = Address.where(id: params[:id]).first

    if @address.present?
      render json: { status: 200, data: @address }
    else
      render json: { status: 404, data: "Endereço não encontrado" }
    end
  end
  
  def create
    @address = Address.create(address_params)

    if @address.save
      render json: { status: 200, data: @address }
    else 
      render json: { status: 500, data: "Falha ao cadastrar endereço" }
    end
  end
  
  def update
    @address = Address.where(id: params[:id]).first
    
    if @address.present?
      @address.update(address_params)
      
      if @address.save
        render json: { status: 200, data: @address }
      else 
        render json: { status: 500, data: "Falha ao editar endereço" }
      end
    else
      render json: { status: 404, data: "Endereço não encontrado" }
    end
  end
  
  def destroy
    @address = Address.where(id: params[:id]).first

    if @address.present?
      @address.destroy
      
      if @address.destroyed?
        render json: { status: 204, data: nil }
      else 
        render json: { status: 500, data: "Falha ao remover endereço" }
      end
    else
      render json: { status: 404, data: "Endereço não encontrado" }
    end
  end

  private

    def address_params
      params.require(:address).permit(:country, :state, :city, :user_id)
    end
end
