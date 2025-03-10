class CreateAddSchoolAndClassToStudents < ActiveRecord::Migration[8.0]
  def change
    add_reference :students, :school_class, null: false, foreign_key: true
    add_reference :students, :school, null: false, foreign_key: true
  end
end
