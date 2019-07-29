class YelpService
  def self.open_restaurants(time_arriving, destination, food_type)
    response = Faraday.get('https://api.yelp.com/v3/businesses/search') do |req|
      req.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
      req.params['location'] = destination
      req.params['term'] = food_type
      req.params['open_at'] = time_arriving.to_i
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
