Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecasts#index'
      get 'backgrounds', to: 'backgrounds#index'
      get 'munchies', to: 'munchies#index'
      resource :users, only: [:create]
      post 'sessions', to: 'sessions#create'
      post 'road_trip', to: 'users/road_trips#index'
    end
  end
  root 'welcome#show'
  match '*path', :to => 'errors#routing', via: [:get, :post]
end
