class GoogleService

  def self.location_data(location)
    response = conn.get("/maps/api/geocode/json?address=#{location}") do |req|
      req.params[:address] = location
      req.params[:key] = ENV['GOOGLE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://maps.googleapis.com')
  end
end
