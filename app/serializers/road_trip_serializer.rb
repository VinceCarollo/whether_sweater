class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin, :destination, :travel_time, :forecast
  set_id { 1 }

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
