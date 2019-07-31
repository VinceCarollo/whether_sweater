class ForecastFacade
  def initialize(params)
    @params = params
  end

  def self.forecast(params)
    new(params).forecast_data
  end

  def forecast_data
    forecast_data = forecast_data_cache
    forecast = Forecast.new(forecast_data, @params[:location])
    ForecastSerializer.new(forecast)
  end

  private

  def forecast_data_cache
    location = @params[:location]
    Rails.cache.fetch(location, expires_in: 1.hours) do
      WeatherService.forecast_data(location)
    end
  end
end
