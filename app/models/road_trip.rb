class RoadTrip
  attr_reader :id
  def initialize(travel_data, weather_data)
    @travel_data = travel_data
    @weather_data = weather_data
    @hours_traveled = Time.at(@travel_data[:routes].first[:legs].first[:duration][:value]).utc.hour + 1
    @id = 1
  end

  def origin
    @travel_data[:routes].first[:legs].first[:start_address]
  end

  def destination
    @travel_data[:routes].first[:legs].first[:end_address]
  end

  def travel_time
    @travel_data[:routes].first[:legs].first[:duration][:text]
  end

  def forecast
    {
      summary: @weather_data[:hourly][:data][@hours_traveled][:summary],
      temperature: @weather_data[:hourly][:data][@hours_traveled][:temperature].round
    }
  end

  def cache_key
    self.class.to_s.downcase + '/1'
  end
end
