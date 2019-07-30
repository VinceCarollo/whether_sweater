class SessionFacade

  def self.successful_login(key)
    {
      status: 200,
      body: {
        api_key: key
      }
    }
  end

  def self.unsuccessful_login
    {
      status: 404,
      description: 'Invalid email/password combination'
    }
  end
end
