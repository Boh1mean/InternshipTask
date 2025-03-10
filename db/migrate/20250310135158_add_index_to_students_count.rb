class AddIndexToStudentsCount < ActiveRecord::Migration[8.0]
  def change
    add_index :school_classes, :students_count
  end
end
