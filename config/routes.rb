Rails.application.routes.draw do
  resources :schools, only: [] do
    resources :school_classes, only: [ :index ] do # GET /schools/id_school/school_classes
        get "students", to: "school_classes#find_students" # GET /schools/id_schools/school_classes/id_school_class/students
    end
  end
  resources :students, only: [ :create, :destroy ] # POST /students
end
