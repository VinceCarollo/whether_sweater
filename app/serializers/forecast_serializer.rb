class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :city_weather
end
