class User < ApplicationRecord
  validates_presence_of :email, :api_key, :password
  has_secure_password
end
