class SchoolClass < ApplicationRecord
  belongs_to :school
  has_many :students

  validates :number, presence: true
  validates :letter, presence: true
  validates :school_id, presence: true

  def update_students_count
    update(students_count: students.count)
  end
end
