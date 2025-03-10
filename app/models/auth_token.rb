class AuthToken < ApplicationRecord
  belongs_to :student
  validates :bearer, presence: true, uniqueness: true

  def as_json(options = {})
    super(options.merge(except: [ :bearer ]))
  end
end
