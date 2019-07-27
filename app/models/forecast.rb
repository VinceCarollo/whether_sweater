class Forecast
  attr_accessor :city_weather, :id
  def initialize(data, location)
    @data = data
    @location = location
    @city_weather = {}
    @id = 1
  end

  def add_data
    add_main_data
    add_details
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
    tonight = @data[:hourly][:data].last[:summary]
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
end
