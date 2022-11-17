class DashboardController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def index
    @available = []
    @requested = []

    if dashboard_params[:profileType] == "1"
      student_request
    else
      teacher_request
    end
  end
 
  private

    def dashboard_params
      params.require(:dashboard).permit(:user_id, :profileType)
    end

    def teacher_request
      available_classes = ClassDetail.where(available: true).order(created_at: :desc)
      available_classes.each do |c|
        @available << Classroom.find(c.classroom_id)
      end
  
      requested_classes = ClassDetail.where(origin: "offered").order(created_at: :desc)
      requested_classes.each do |c|
        @requested = Teacher.find_by(user_id: dashboard_params[:user_id]).classrooms.where(id: c.classroom_id)
      end
      
      @subjects = Subject.order(name: :asc)
  
      render json: { 
        status: 200,
        data: {
          available: @available,
          requested: @requested,
          subjects: @subjects,
        }
      }
    end

    def student_request
      available_classes = ClassDetail.where(available: true).order(created_at: :desc)
      available_classes.each do |c|
        @available << Classroom.find(c.classroom_id)
      end
  
      requested_classes = ClassDetail.where(origin: "requested").order(created_at: :desc)
      requested_classes.each do |c|
        @requested = Student.find_by(user_id: dashboard_params[:user_id]).classrooms.where(id: c.classroom_id)
      end
      
      @subjects = Subject.order(name: :asc)
  
      render json: { 
        status: 200,
        data: {
          available: @available,
          requested: @requested,
          subjects: @subjects,
        }
      }
    end
end
