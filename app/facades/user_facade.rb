require 'api_key'

class UserFacade

  def self.user_created(key)
    {
      status: 201,
      body: {
        api_key: key
      }
    }
  end

  def self.user_not_created(errors)
    {
      status: 409,
      errors: errors
    }
  end
end
