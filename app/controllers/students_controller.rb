class StudentsController < ApplicationController
  def create
    school = School.find_or_create_by!(id: params[:student][:school_id]) do |s|
      s.name = "Школа №#{params[:student][:school_id]}"
    end

    unless params[:student][:class_number] && params[:student][:class_letter]
      raise ArgumentError, "Необходимо передать class_number и class_letter для создания класса"
    end

    school_class = SchoolClass.find_or_create_by!(
      id: params[:student][:school_class_id],
      school_id: school.id
    ) do |sc|
      sc.number = params[:student][:class_number]
      sc.letter = params[:student][:class_letter]
    end

    student = Student.new(student_params)
    Rails.logger.info "Созданный студент: #{student.inspect}"

    if student.save
      raw_token = AuthToken.generate_raw_token(student.id)
      token = AuthToken.create!(student: student, bearer: Digest::SHA256.hexdigest(raw_token))

      render json: {
        id: student.id,
        first_name: student.first_name,
        last_name: student.last_name,
        surname: student.surname,
        school: {
          id: school.id,
          name: school.name
        },
        school_class: {
          id: school_class.id,
          number: school_class.number,
          letter: school_class.letter
        },
        token: token.bearer
      }, status: :created
    else
      Rails.logger.error "Ошибки сохранения: #{student.errors.full_messages.inspect}"
      render json: { error: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    def destroy
      token = request.headers["Authorization"]&.split(" ")&.last
      student_id = params[:id]

      Rails.logger.debug "Полученный токен: #{token}"
      Rails.logger.debug "ID студента: #{student_id}"

      unless student_id.to_i.positive?
        return render json: { error: "Некорректный ID студента" }, status: :bad_request
      end

      unless token
        return render json: { error: "Токен авторизации отсутствует" }, status: :unauthorized
      end

      auth_token = AuthToken.authenticate(token)
      unless auth_token
        return render json: { error: "Некорректная авторизация" }, status: :unauthorized
      end

      unless auth_token.student_id == student_id.to_i
        return render json: { error: "Токен не принадлежит указанному студенту" }, status: :forbidden
      end

      student = auth_token.student
      auth_token.destroy
      student.destroy

      render json: { message: "Студент и его токен удалены." }, status: :ok

    rescue ActiveRecord::RecordNotFound => e
      render json: { error: "Не удалось найти запись: #{e.message}" }, status: :not_found

    rescue StandardError => e
      Rails.logger.error "Ошибка при удалении студента: #{e.message}"
      render json: { error: "Внутренняя ошибка сервера: #{e.message}" }, status: :internal_server_error
    end
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :surname, :school_class_id, :school_id)
  end
end
