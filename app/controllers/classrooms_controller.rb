class ClassroomsController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  def index
    @classrooms = Classroom.all

    if @classrooms
      render json: { status: 200, data: @classrooms }
    else
      render json: { status: 500, data: "Falha ao buscar classes" }
    end
  end
  
  def show
    @classroom = Classroom.where(id: params[:id]).first

    if @classroom.present?
      render json: { status: 200, data: @classroom }
    else
      render json: { status: 404, data: "Classe não encontrado" }
    end
  end
  
  def create
    @classroom = Classroom.create(classrooms_params)

    if @classroom.save
      render json: { status: 200, data: @classroom }
    else 
      render json: { status: 500, data: "Falha ao cadastrar classe" }
    end
  end
  
  def update
    @classroom = Classroom.where(id: params[:id]).first
    
    if @classroom.present?
      @classroom.update(classrooms_params)
      
      if @classroom.save
        render json: { status: 200, data: @classroom }
      else 
        render json: { status: 500, data: "Falha ao editar classe" }
      end
    else
      render json: { status: 404, data: "Classe não encontrado" }
    end
  end
  
  def destroy
    @classroom = Classroom.where(id: params[:id]).first

    if @classroom.present?
      @classroom.destroy
      
      if @classroom.destroyed?
        render json: { status: 204, data: nil }
      else 
        render json: { status: 500, data: "Falha ao remover classe" }
      end
    else
      render json: { status: 404, data: "Classe não encontrado" }
    end
  end

  private

    def classrooms_params
      params.require(:classroom).permit(:teacher_id, :subject_id)
    end
end
