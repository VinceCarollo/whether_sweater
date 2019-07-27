class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :weather_for_city
end
