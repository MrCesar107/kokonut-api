Rails.application.routes.draw do
  devise_for :users

  namespace :v1 do
    resources :authentications, only: %i[create]
    resource :password, only: %i[create update]
    namespace :sessions do
      resource :facebook, only: %i[create]
    end
    resources :users, except: %i[destroy] do
      resources :photos, only: %i[index show create destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
