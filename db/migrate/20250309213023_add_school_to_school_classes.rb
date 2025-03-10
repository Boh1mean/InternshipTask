class AddSchoolToSchoolClasses < ActiveRecord::Migration[8.0]
  def change
    remove_column :school_classes, :school_id, if_exists: true
    add_reference :school_classes, :school, null: false, foreign_key: true, index: true
    change_column_null :school_classes, :number, false
    change_column_null :school_classes, :letter, false
    change_column_default :school_classes, :students_count, from: nil, to: 0
  end
end
