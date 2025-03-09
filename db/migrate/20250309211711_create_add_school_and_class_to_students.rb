class CreateAddSchoolAndClassToStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :add_school_and_class_to_students do |t|
      t.references :students, :school_class, null: false, foreign_key: true
      t.references :students, :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
