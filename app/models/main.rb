class Main
  attr_accessor :city,
                :summary,
                :temperature,
                :high,
                :low,
                :country,
                :time,
                :date,
                :icon

  def initialize(main_data, location)
    @city = location.insert(-3, ' ')
    @summary = main_data[:currently][:summary]
    @temperature = main_data[:currently][:temperature].round
    @high = main_data[:daily][:data].first[:temperatureHigh].round
    @low = main_data[:daily][:data].first[:temperatureLow].round
    @country = main_data[:timezone].split('/').first
    @time = Time.at(main_data[:currently][:time]).strftime("%I:%M %p")
    @date = Time.at(main_data[:currently][:time]).month.to_s + '/' + Time.at(main_data[:currently][:time]).day.to_s
    @icon = main_data[:currently][:icon]
  end
end
