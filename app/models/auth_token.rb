require "digest"
require "securerandom"

class AuthToken < ApplicationRecord
  belongs_to :student
  validates :bearer, presence: true, uniqueness: true
  validates :student_id, presence: true


  before_create :generate_token

  def self.generate_raw_token(student_id)
    secret_salt = Rails.application.credentials.secret_key_base
    raw_token = "#{student_id}:#{secret_salt}"
    Digest::SHA256.hexdigest(raw_token)
  end

  def self.authenticate(token)
    digest = Digest::SHA256.hexdigest(token)
    find_by(bearer: digest)
  end


  private

  def generate_token
    self.bearer = AuthToken.generate_raw_token(student_id)
  end
end
