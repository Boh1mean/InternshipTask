class Student < ApplicationRecord
  validates :first_name, :last_name, presence: true
  belongs_to :school_class, counter_cache: true
  belongs_to :school
end
