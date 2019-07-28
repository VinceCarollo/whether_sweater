class ImageService
  def self.backgrounds(city)
    response = Faraday.get('https://api.unsplash.com/search/photos') do |req|
      req.params[:query] = city
      req.params[:client_id] = ENV['UNSPLASH_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
