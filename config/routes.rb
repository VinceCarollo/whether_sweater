Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecasts#index'
      get 'backgrounds', to: 'backgrounds#index'
    end
  end
  match '*path', :to => 'errors#routing', via: [:get, :post]
end
