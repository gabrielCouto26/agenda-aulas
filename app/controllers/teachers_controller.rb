class TeachersController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  def index
    @teachers = Teacher.all

    if @teachers
      render json: { status: 200, data: @teachers }
    else
      render json: { status: 500, data: "Falha ao buscar professores" }
    end
  end
  
  def show
    @teacher = Teacher.where(id: params[:id]).first

    if @teacher.present?
      render json: { status: 200, data: @teacher }
    else
      render json: { status: 404, data: "Professor não encontrado" }
    end
  end
  
  def create
    @teacher = Teacher.create(teachers_params)

    if @teacher.save
      render json: { status: 200, data: @teacher }
    else 
      render json: { status: 500, data: "Falha ao cadastrar professor" }
    end
  end
  
  def update
    @teacher = Teacher.where(id: params[:id]).first
    
    if @teacher.present?
      @teacher.update(teachers_params)
      
      if @teacher.save
        render json: { status: 200, data: @teacher }
      else 
        render json: { status: 500, data: "Falha ao editar professor" }
      end
    else
      render json: { status: 404, data: "Professor não encontrado" }
    end
  end
  
  def destroy
    @teacher = Teacher.where(id: params[:id]).first

    if @teacher.present?
      @teacher.destroy
      
      if @teacher.destroyed?
        render json: { status: 204, data: nil }
      else 
        render json: { status: 500, data: "Falha ao remover professor" }
      end
    else
      render json: { status: 404, data: "Professor não encontrado" }
    end
  end

  private

    def teachers_params
      params.require(:teacher).permit(:teacher_since, :domain, :experience, :user_id)
    end
end
