class DashboardController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def index
    # Lista de classes ativas (class_details available: true )
    available_ids = ClassDetail.where(available: true)
    available_ids.each do |id|
      @available_classes << Classroom.find(id)
    end
    
    # Lista de classes desejadas (class_details origin: requested )
    requested_ids = ClassDetail.where(origin: "requested")
    requested_ids.each do |id|
      @requested_classes << Classroom.find(id)
    end
    
    # Lista de topicos (subject all order by name desc)
    @subjects = Subject.order(name: :asc)

    render json: { 
      status: 200,
      data: {
        available: @available_classes,
        requested: @requested_classes,
        subjects: @subjects,
      }
    }
  end
end
