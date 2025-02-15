Rails.application.routes.draw do
  get "memberships/create"
  get "memberships/destroy"
  get "memberships/update"
  devise_for :users

  root "posts#index"

  resources :follows, only: [:create, :destroy]

  resources :communities, only: [:index, :show] do
    resource :membership, only: [:create, :destroy, :update]
    resources :posts, only: [:new, :create]
  end

  resources :posts, only: [:index, :show] do
    resources :comments, only: [:create]
    member do
      post :upvote, to:'votes#upvote'
      post :downvote, to: 'votes#downvote' 
    end
  end

  authenticated :user do
    root to: "posts#index", as: :authenticated_root
  end

  unauthenticated do
    devise_scope :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  get '/:username', to: "users#show", as: :user_profile
end
