class DashboardController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def index
    @available = []
    @requested = []

    available_classes = ClassDetail.where(available: true).order(created_at: :desc)
    available_classes.each do |c|
      @available << Classroom.find(c.classroom_id)
    end
    
    requested_classes = ClassDetail.where(origin: "requested").order(created_at: :desc)
    requested_classes.each do |c|
      @requested << Classroom.find(c.classroom_id)
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
