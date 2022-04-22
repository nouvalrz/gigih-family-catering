Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories
      resources :menus
      resources :orders, :except => [:index, :update]
      resources :reports, :only => [:index]


      patch '/orders/:id', to: 'orders#update_status'
      put '/orders/:id', to: 'orders#update'
    end
  end
end
