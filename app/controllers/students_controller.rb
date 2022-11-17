class StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  def index
    @students = Student.all

    if @students
      render json: { status: 200, data: @students }
    else
      render json: { status: 500, data: "Falha ao buscar alunos" }
    end
  end
  
  def show
    @student = Student.where(id: params[:id]).first

    if @student.present?
      render json: { status: 200, data: @student }
    else
      render json: { status: 404, data: "Aluno não encontrado" }
    end
  end

  def show_by_user
    @student = Student.where(user_id: params[:user_id]).first

    if @student.present?
      render json: { status: 200, data: @student }
    else
      render json: { status: 404, data: "Aluno não encontrado" }
    end
  end
  
  def create
    @student = Student.create(students_params)

    if @student.save
      render json: { status: 200, data: @student }
    else 
      render json: { status: 500, data: "Falha ao cadastrar aluno" }
    end
  end
  
  def update
    @student = Student.where(id: params[:id]).first
    
    if @student.present?
      @student.update(students_params)
      
      if @student.save
        render json: { status: 200, data: @student }
      else 
        render json: { status: 500, data: "Falha ao editar aluno" }
      end
    else
      render json: { status: 404, data: "Aluno não encontrado" }
    end
  end
  
  def destroy
    @student = Student.where(id: params[:id]).first

    if @student.present?
      @student.destroy
      
      if @student.destroyed?
        render json: { status: 204, data: nil }
      else 
        render json: { status: 500, data: "Falha ao remover aluno" }
      end
    else
      render json: { status: 404, data: "Aluno não encontrado" }
    end
  end

  private

    def students_params
      params.require(:student).permit(:formation_level, :user_id)
    end
end
