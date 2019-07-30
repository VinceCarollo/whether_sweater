class MunchieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin, :destination, :travel_time, :restaurants
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

  def restaurants
    object.restaurants
  end
end
