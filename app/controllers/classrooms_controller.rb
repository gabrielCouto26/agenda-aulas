class ClassroomsController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  def index
    if params[:student_id]
      student = Student.where(id: params[:student_id]).first
      if student.present?
        @classrooms = student.classrooms
        render json: { status: 200, data: @classrooms }
      else
        render json: { status: 404, data: "Aluno não encontrado" }
      end
    else
      @classrooms = Classroom.all
      if @classrooms
        render json: { status: 200, data: @classrooms }
      else
        render json: { status: 500, data: "Falha ao buscar classes" }
      end
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
    if params[:student_id] or params[:teacher_id]
      student_create(params[:student_id], classrooms_params[:subject_id]) if params[:student_id]
      teacher_create(params[:teacher_id], classrooms_params[:subject_id]) if params[:teacher_id]
    else
      @classroom = Classroom.create(classrooms_params)

      if @classroom.save
        render json: { status: 200, data: @classroom }
      else 
        render json: { status: 500, data: "Falha ao cadastrar classe" }
      end
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
    if params[:student_id]
      student = Student.where(id: params[:student_id]).first
      if student.present?
        @classroom = student.classrooms.where(id: params[:id]).first
        if @classroom.present?
          @classroom.destroy
          if @classroom.destroyed?
            render json: { status: 204, data: nil }
          else 
            render json: { status: 500, data: "Falha ao remover classe" }
          end
        else
          render json: { status: 404, data: "Classe não encontrada" }
        end
      else
        render json: { status: 404, data: "Aluno não encontrado" }
      end
    else
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
  end

  private

    def classrooms_params
      params.require(:classroom).permit(:teacher_id, :subject_id, :student_id)
    end

    def student_create(id, subject_id)
      student = Student.where(id: id).first
      if student.present?
        @classroom = student.classrooms.create!(subject_id: subject_id)
        render json: { status: 200, data: @classroom }
      else
        render json: { status: 404, data: "Aluno não encontrado" }
      end
    end
  
    def teacher_create(id, subject_id)
      teacher = Teacher.where(id: id).first
      if teacher.present?
        @classroom = teacher.classrooms.create!(subject_id: subject_id)
        render json: { status: 200, data: @classroom }
      else
        render json: { status: 404, data: "Professor não encontrado" }
      end
    end
end
