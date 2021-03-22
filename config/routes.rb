Rails.application.routes.draw do
  resources :friendships
  resources :posts
  resources :conversations

  resources :likes, only: [:new, :show]
  resources :messages, only: [:new]

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users do
    resources :posts
    resources :likes
  end

  resources :friendships do
    resources :conversations
  end

  root to: 'welcome#index'
end
