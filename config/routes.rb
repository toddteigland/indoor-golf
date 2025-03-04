Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :rounds
  resources :scores do
    collection do
      get :admin_scores
    end
  end
  get 'playoffs', to: 'home#playoffs', as: 'playoffs'
  patch '/playoff_result', to: 'home#playoff_result', as: 'playoff_result'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
