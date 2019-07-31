class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :main, :details, :ext_forecast
  set_id { 1 }

  def main
    object.main
  end

  def details
    object.details
  end

  def ext_forecast
    object.ext_forecast
  end
end
