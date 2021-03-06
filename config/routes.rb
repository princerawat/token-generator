Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  resources :access_token, only: [:index] do
    collection do
      get :assign
      put :unblock
      put :keep_alive
      delete :delete
    end
  end
end
