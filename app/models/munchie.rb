class Munchie

  def add_travel_data(data)
    @origin = data[:routes].first[:legs].first[:start_address]
    @destination = data[:routes].first[:legs].first[:end_address]
    @travel_time = data[:routes].first[:legs].first[:duration][:text]
  end

  def add_restaurant_data(data)
    @businesses = data[:businesses][0..2].map do |business|
      binding.pry
    end
  end
end
