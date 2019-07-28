class ImageService
  def self.backgrounds(city)
    response = image_request(city)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.image_request(city)
    Faraday.get('https://api.unsplash.com/search/photos') do |req|
      req.params[:query] = city
      req.params[:client_id] = ENV['UNSPLASH_API_KEY']
    end
  end
end
