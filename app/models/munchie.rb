class Munchie

  def initialize(travel_data, restaurant_data)
    @travel_data = travel_data
    @restaurant_data = restaurant_data
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

  def restaurants
    @restaurant_data[:businesses][0..2].map do |business|
      {
      name:           business[:name],
      street_address: business[:location][:address1],
      city:           business[:location][:city],
      zip:            business[:location][:zip_code]
      }
    end
  end

end
