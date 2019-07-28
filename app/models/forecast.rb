class Forecast
  attr_reader :city_weather
  def initialize(data, location)
    @data = data
    @location = location
    @city_weather = {}
  end

  def add_data
    add_main_data
    add_details
    add_extended_forecast
  end

  def add_main_data
    summary = @data[:currently][:summary]
    temperature = @data[:currently][:temperature].round
    high = @data[:daily][:data].first[:temperatureHigh].round
    low = @data[:daily][:data].first[:temperatureLow].round
    country = @data[:timezone].split('/').first
    time = Time.at(@data[:currently][:time]).strftime("%I:%M %p")
    date = Time.at(@data[:currently][:time]).month.to_s + '/' + Time.at(@data[:currently][:time]).day.to_s
    icon = @data[:currently][:icon]
    city = @location.insert(-3, ' ')
    @city_weather[:main] = {
      city: city,
      summary: summary,
      temperature: temperature,
      high: high,
      low: low,
      country: country,
      time: time,
      date: date,
      icon: icon
    }
  end

  def add_details
    summary = @data[:currently][:summary]
    icon = @data[:currently][:icon]
    today = @data[:hourly][:summary]
    tonight = @data[:hourly][:data][9][:summary]
    feels_like = @data[:currently][:apparentTemperature].round
    humidity = (@data[:currently][:humidity] * 100).round
    visibility = @data[:currently][:visibility]
    uv_index = @data[:currently][:uvIndex]
    @city_weather[:details] = {
      summary: summary,
      icon: icon,
      today: today,
      tonight: tonight,
      feels_like: feels_like,
      humidity: humidity,
      visibility: visibility,
      uv_index: uv_index
    }
  end

  def add_extended_forecast
    hourly = Array.new
    daily = Array.new
    @data[:hourly][:data][0..7].each do |hour|
      stats = {
        time: Time.at(hour[:time]).strftime("%I:%M %p"),
        temperature: hour[:temperature].round
      }
      hourly << stats
    end
    @data[:daily][:data][1..5].each do |day|
      stats = {
        week_day: Time.at(day[:time]).strftime("%A"),
        summary: day[:summary],
        icon: day[:icon],
        precip: (day[:precipProbability] * 100).round,
        high: day[:temperatureHigh].round,
        low: day[:temperatureLow].round
      }
      daily << stats
    end
    @city_weather[:extended_forecast] = {
      hourly: hourly,
      daily: daily
    }
  end
end
