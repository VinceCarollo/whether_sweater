class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  cache_options enabled: true, cache_length: 1.hour
  attributes :origin, :destination, :travel_time, :forecast

  def origin
    object.origin
  end

  def destination
    object.destination
  end

  def travel_time
    object.travel_time
  end

  def forecast
    object.forecast
  end
end
