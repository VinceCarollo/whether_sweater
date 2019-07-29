class GoogleService

  def self.location_data(location)
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params[:address] = location
      req.params[:key] = ENV['GOOGLE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
