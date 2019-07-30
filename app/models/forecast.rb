class Forecast
  attr_reader :main, :details, :ext_forecast

  def initialize(forecast_data, location)
    @data = forecast_data
    @location = location
  end

  def main
    {
      location:    @location.insert(-3, ' '),
      summary:     @data[:currently][:summary],
      temperature: @data[:currently][:temperature].round,
      high:        @data[:daily][:data].first[:temperatureHigh].round,
      low:         @data[:daily][:data].first[:temperatureLow].round,
      country:     @data[:timezone].split('/').first,
      time:        Time.at(@data[:currently][:time]).strftime("%I:%M %p"),
      date:        Time.at(@data[:currently][:time]).strftime("%-m/%-d"),
      icon:        @data[:currently][:icon]
    }
  end

  def details
    {
      summary:    @data[:currently][:summary],
      icon:       @data[:currently][:icon],
      today:      @data[:hourly][:summary],
      tonight:    @data[:hourly][:data][9][:summary],
      feels_like: @data[:currently][:apparentTemperature].round,
      humidity:  (@data[:currently][:humidity] * 100).round,
      visibility: @data[:currently][:visibility],
      uv_index:   @data[:currently][:uvIndex]
    }
  end

  def ext_forecast
    daily = daily_data
    hourly = hourly_data
    {
      hourly: hourly,
      daily: daily
    }
  end

  private

  def hourly_data
    @data[:hourly][:data][0..7].map do |hour|
      {
        time: Time.at(hour[:time]).strftime("%I:%M %p"),
        temperature: hour[:temperature].round
      }
    end
  end

  def daily_data
    @data[:daily][:data][1..5].map do |day|
      {
        week_day: Time.at(day[:time]).strftime("%A"),
        summary: day[:summary],
        icon: day[:icon],
        precip: (day[:precipProbability] * 100).round,
        high: day[:temperatureHigh].round,
        low: day[:temperatureLow].round
      }
    end
  end
end
