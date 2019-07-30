class ForecastFacade
  def self.forecast_data(params)
    location = params[:location]
    city_weather = city_weather(location)
    { data: city_weather }
  end

  private

  def self.city_weather(location)
    forecast_data = WeatherService.forecast_data(location)
    forecast = Forecast.new
    forecast.add_data(forecast_data, location)
    forecast
  end
end
