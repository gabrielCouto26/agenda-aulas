class ClassDetailsController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  def index
    @class_details = ClassDetail.all

    if @class_details
      render json: { status: 200, data: @class_details }
    else
      render json: { status: 500, data: "Falha ao buscar detalhes da classe" }
    end
  end
  
  def show
    @class_detail = ClassDetail.where(id: params[:id]).first

    if @class_detail.present?
      render json: { status: 200, data: @class_detail }
    else
      render json: { status: 404, data: "Detalhes da classe não encontrado" }
    end
  end

  def show_by_classroom
    @class_detail = ClassDetail.where(classroom_id: params[:classroom_id]).first

    if @class_detail.present?
      render json: { status: 200, data: @class_detail }
    else
      render json: { status: 404, data: "Detalhes da classe não encontrado" }
    end
  end
  
  def create
    @class_detail = ClassDetail.create(class_details_params)

    if @class_detail.save
      render json: { status: 200, data: @class_detail }
    else 
      render json: { status: 500, data: "Falha ao cadastrar detalhes da classe" }
    end
  end
  
  def update
    @class_detail = ClassDetail.where(id: params[:id]).first
    
    if @class_detail.present?
      @class_detail.update(class_details_params)
      
      if @class_detail.save
        render json: { status: 200, data: @class_detail }
      else 
        render json: { status: 500, data: "Falha ao editar detalhes da classe" }
      end
    else
      render json: { status: 404, data: "Detalhes da classe não encontrado" }
    end
  end
  
  def destroy
    @class_detail = ClassDetail.where(id: params[:id]).first

    if @class_detail.present?
      @class_detail.destroy
      
      if @class_detail.destroyed?
        render json: { status: 204, data: nil }
      else 
        render json: { status: 500, data: "Falha ao remover detalhes da classe" }
      end
    else
      render json: { status: 404, data: "Detalhes da classe não encontrado" }
    end
  end

  private

    def class_details_params
      params.require(:class_detail).permit(:price, :schedule, :duration, :online, :origin, :available, :active, :classroom_id)
    end
end
