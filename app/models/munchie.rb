class Munchie

  def add_travel_data(data)
    @origin = data[:routes].first[:legs].first[:start_address]
    @destination = data[:routes].first[:legs].first[:end_address]
    @travel_time = data[:routes].first[:legs].first[:duration][:text]
  end

  def add_restaurant_data(data)
    @restaurants = data[:businesses][0..2].map do |business|
      {
      name: business[:name],
      street_address: business[:location][:address1],
      city: business[:location][:city],
      zip: business[:location][:zip_code]
      }
    end
  end
  
end
