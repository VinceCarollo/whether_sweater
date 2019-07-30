class MunchieFacade
  def self.munchie_data(params)
    @params = params
    travel_data = travel_time_service
    restaurant_data = restaurant_service(travel_data)
    munchie = initiate_munchie(travel_data, restaurant_data)
    { data: munchie }
  end

  private

  def self.initiate_munchie(travel_data, restaurant_data)
    munchie = Munchie.new
    munchie.add_data(travel_data, restaurant_data)
    munchie
  end

  def self.restaurant_service(travel_data)
    travel_time = travel_data[:routes].first[:legs].first[:duration][:value]
    hours_traveled = Time.at(travel_time).utc.hour
    minutes_traveled = Time.at(travel_time).utc.min
    time_arriving = Time.now + hours_traveled.hours + minutes_traveled.minutes
    YelpService.open_restaurants(time_arriving, @params[:end], @params[:food])
  end

  def self.travel_time_service
    start_city = @params[:start]
    end_city = @params[:end]
    GoogleService.travel_time(start_city, end_city)
  end

end
