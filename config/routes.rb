Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecasts#index'
      get 'backgrounds', to: 'backgrounds#index'
      get 'munchies', to: 'munchies#index'
      resource :users, only: [:create]
      post 'sessions', to: 'sessions#create'
    end
  end
  # match '*path', :to => 'errors#routing', via: [:get, :post]
end
