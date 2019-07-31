class BackgroundFacade

  def initialize(params)
    @params = params
  end

  def self.backgrounds(params)
    new(params).background_data
  end

  def background_data
    city = @params[:location].split(',').first
    images_data = ImageService.backgrounds(city)
    images = serialize(images_data)
    if images.empty?
      { data: 'No Images Found' }
    else
      { data: images }
    end
  end

  private

  def serialize(images_data)
    images_data[:results][0..9].map do |image_data|
      {
        url: image_data[:urls][:full],
        alt_description: image_data[:alt_description]
      }
    end
  end
end
