class GoogleService

  def self.location_data(location)
    response = conn.get("/maps/api/geocode/json?address=#{location}") do |req|
      req.params[:address] = location
      req.params[:key] = ENV['GOOGLE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.travel_time(start_city, end_city)
    response = conn.get('/maps/api/directions/json') do |req|
      req.params[:origin] = start_city
      req.params[:destination] = end_city
      req.params[:key] = ENV['GOOGLE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('https://maps.googleapis.com')
  end
end
