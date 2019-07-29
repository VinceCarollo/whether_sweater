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
    GoogleService.location_data(location)
  end
end
