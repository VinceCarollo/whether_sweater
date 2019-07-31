class ForecastFacade
  def initialize(params)
    @params = params
  end

  def self.forecast(params)
    new(params).forecast_data
  end

  def forecast_data
    location = @params[:location]
    forecast_data = WeatherService.forecast_data(location)
    forecast = Forecast.new(forecast_data, location)
    ForecastSerializer.new(forecast)
  end
end
