class Forecast
  attr_accessor :weather_for_city, :id
  def initialize(data, location)
    @data = data
    @location = location
    @weather_for_city = {}
    @id = 1
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
    @weather_for_city[:main] = {
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
end
