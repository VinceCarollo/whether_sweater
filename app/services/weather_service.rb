class WeatherService
  def self.forecast_data(location)
    location_data = location_data(location)
    lat = location_data[:results].first[:geometry][:location][:lat]
    lng = location_data[:results].first[:geometry][:location][:lng]
    response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{lat},#{lng}")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.location_data(location)
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params[:address] = location
      req.params[:key] = ENV['GOOGLE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
