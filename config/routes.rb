Rails.application.routes.draw do
  config = Rails.application.config.baukis2

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: %i(create destroy)
      resource :account, except: %i(new create destroy)
      resource :password, only: %i(show edit update)
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: %i(create destroy)
      resources :staff_members do
        resources :staff_events, only: %i(index)
      end
      resources :staff_events, only: %i(index)
    end
  end

  namespace :customer do
    root "top#index"
  end
end
