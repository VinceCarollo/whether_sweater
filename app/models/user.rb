require 'api_key'

class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :api_key, :password
  has_secure_password

  before_validation :assign_key

  def assign_key
    self.api_key = ApiKey.generator
  end
end
