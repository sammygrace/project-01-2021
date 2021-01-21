Rails.application.routes.draw do
  resources :messages
  resources :friendships
  resources :conversations
  resources :posts

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users do
    resources :posts
  end

  resources :friendships do
    resources :conversations
  end

  root to: 'welcome#index'
end
