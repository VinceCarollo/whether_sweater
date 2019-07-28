class User < ApplicationRecord
  include ApiKey
  validates_presence_of :email, :api_key, :password
  has_secure_password

  before_validation :assign_key

  def assign_key
    self.api_key = ApiKey.generator
  end
end
