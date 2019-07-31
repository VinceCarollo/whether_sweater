class MunchieFacade
  def initialize(params)
    @params = params
  end

  def self.munchie(params)
    new(params).munchie_data
  end

  def munchie_data
    travel_data = travel_time_service
    restaurant_data = restaurant_service(travel_data)
    munchie = Munchie.new(travel_data, restaurant_data)
    MunchieSerializer.new(munchie)
  end

  private

  def restaurant_service(travel_data)
    travel_time = travel_data[:routes].first[:legs].first[:duration][:value]
    hours_traveled = Time.at(travel_time).utc.hour
    minutes_traveled = Time.at(travel_time).utc.min
    time_arriving = Time.now + hours_traveled.hours + minutes_traveled.minutes
    Rails.cache.fetch("#{@params[:food]}/#{@params[:start]}/#{@params[:end]}", expires_in: 1.hour) do
      YelpService.open_restaurants(time_arriving, @params[:end], @params[:food])
    end
  end

  def travel_time_service
    start_city = @params[:start]
    end_city = @params[:end]
    Rails.cache.fetch("#{start_city}/#{end_city}", expires_in: 1.hour) do
      GoogleService.travel_time(start_city, end_city)
    end
  end

end
