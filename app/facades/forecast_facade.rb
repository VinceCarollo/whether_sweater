class ForecastFacade
  def initialize(params)
    @params = params
  end

  def self.forecast(params)
    new(params).forecast_data
  end

  def forecast_data
    location = @params[:location]
    city_weather = city_weather(location)
    { data: city_weather }
  end

  private

  def city_weather(location)
    forecast_data = WeatherService.forecast_data(location)
    forecast = Forecast.new
    forecast.add_data(forecast_data, location)
    forecast
  end
end
