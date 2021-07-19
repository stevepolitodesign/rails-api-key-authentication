Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  authenticated :user do
    devise_scope :user do 
      root "devise/registrations#edit", as: :authenticated_root
    end
  end

  devise_scope :user do 
    root "devise/sessions#new"
  end
  devise_for :users

  namespace :user do
    resource :private_api_keys, only: :update
  end

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :posts, only: [:index, :create, :show, :update, :destroy]
      end
    end
  end

end
