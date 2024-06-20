Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :users, only: %i[show edit update create] do
    collection do
      post :search
    end
  end
  
  # Defines the root path route ("/")
  # root "posts#index"
  root 'users#index'
end
