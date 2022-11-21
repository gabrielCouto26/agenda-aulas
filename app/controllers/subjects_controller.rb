class SubjectsController < ApplicationController
  skip_before_action :verify_authenticity_token  
  
  def index
    @subjects = Subject.all

    if @subjects
      render json: { status: 200, data: @subjects }
    else
      render json: { status: 500, data: "Falha ao buscar tópicos" }
    end
  end
  
  def show
    @subject = Subject.where(id: params[:id]).first

    if @subject.present?
      render json: { status: 200, data: @subject }
    else
      render json: { status: 404, data: "Tópico não encontrado" }
    end
  end

  def list_classrooms
    @subject = Subject.where(id: params[:subject_id]).first

    if @subject.present?
      classrooms = []
      if @subject.classrooms.any?
        @subject.classrooms.each do |c|
          classrooms << {id: c.id, name: c.name}
        end
      end
      render json: { status: 200, data: classrooms }
    else
      render json: { status: 404, data: "Tópico não encontrado" }
    end
  end
  
  def create
    @subject = Subject.create(subjects_params)

    if @subject.save
      render json: { status: 200, data: @subject }
    else 
      render json: { status: 500, data: "Falha ao cadastrar tópico" }
    end
  end
  
  def update
    @subject = Subject.where(id: params[:id]).first
    
    if @subject.present?
      @subject.update(subjects_params)
      
      if @subject.save
        render json: { status: 200, data: @subject }
      else 
        render json: { status: 500, data: "Falha ao editar tópico" }
      end
    else
      render json: { status: 404, data: "Tópico não encontrado" }
    end
  end
  
  def destroy
    @subject = Subject.where(id: params[:id]).first

    if @subject.present?
      @subject.destroy
      
      if @subject.destroyed?
        render json: { status: 204, data: nil }
      else 
        render json: { status: 500, data: "Falha ao remover tópico" }
      end
    else
      render json: { status: 404, data: "Tópico não encontrado" }
    end
  end

  private

    def subjects_params
      params.require(:subject).permit(:name)
    end
end
