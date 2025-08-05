Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Admin routes
  namespace :admin do
    get '/', to: 'admin#index'
    get '/bulk_image_upload', to: 'admin#bulk_image_upload'
    post '/process_bulk_upload', to: 'admin#process_bulk_upload'
    get '/image_management', to: 'admin#image_management'
    delete '/delete_image/:id/:image_type', to: 'admin#delete_image', as: :delete_image
  end

  # Currency routes
  resources :currencies, only: [:index, :show] do
    resources :currency_denominations, only: [:index, :show, :edit, :update]
  end
  
  # Collection routes
  resources :currency_collections
  
  # Defines the root path route ("/")
  root "currencies#index"
end
