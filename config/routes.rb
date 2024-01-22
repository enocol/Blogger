Rails.application.routes.draw do
  # resources :likes
  # resources :comments
  # resources :posts
  get 'users/:id', to: 'users#show', as: 'user'
  get 'users/:id/posts', to: 'users#posts', as: :user_posts
  get 'users/:id/posts/:id', to: 'users#show_user_post', as: 'show_user_post'
  # get 'users/:id/posts/:post_id', to: 'users#show_user_post', as: 'user_post'
  
  # resources :users
  
  # resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  

  # Defines the root path route ("/")
  root "users#index"
end
