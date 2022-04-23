Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories
      resources :menus
      resources :orders, :except => [:update]
      resources :reports, :only => [:index]


      patch '/orders/update-status', to: 'orders#update_status_all'
      patch '/orders/:id', to: 'orders#update_status'
      put '/orders/:id', to: 'orders#update'
    end
  end
end
