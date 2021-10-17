Rails.application.routes.draw do
  resources :ratings
  resources :comments
  resources :user_shows
  resources :shows
  resources :users

  namespace :api do
    namespace :v1 do
      resources :auth
    end
  end

  match '*path', to: ->(env) { [404, {}, ['Not Found']] }, via: :all
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
