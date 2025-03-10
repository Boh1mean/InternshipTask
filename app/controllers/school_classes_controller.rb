class SchoolClassesController < ApplicationController
  def index
    school_id = params[:school_id]
    school_classes = SchoolClass.where(school_id: school_id)

    render json: { data: school_classes }, status: :ok
  rescue StandardError => e
    render json: { error: "Ошибка: #{e.message}" }, status: :internal_server_error
  end

  def find_students
    school_id = params[:school_id]
    class_id = params[:school_class_id]
    Rails.logger.info "Поиск студентов в школе #{school_id}, классе #{class_id}"

    students = Student.where(school_class_id: class_id, school_id: school_id)

    Rails.logger.info "Найдено студентов: #{students.inspect}"


    render json: { data: students }, status: :ok
  rescue StandardError => e
    render json: { error: "Ошибка: #{e.message}" }, status: :internal_server_error
  end
end
