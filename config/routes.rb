require 'sidekiq/web'

Rails.application.routes.draw do
  resources :martian_places
  resources :martian_weather_stations
  resources :urban_images
  # resources :city_images
  # resources :background_photos
  resources :cities do
    resources :background_photos, shallow: true
    resources :urban_images, shallow: true
  end
  get 'mars/index'
  resources :projects do
    resources :project_users, path: :users, module: :projects
  end
  namespace :admin do
    resources :users
    resources :announcements
    resources :notifications
    resources :services

    root to: "users#index"
  end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  resources :notifications, only: [:index]
  resources :mars, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
