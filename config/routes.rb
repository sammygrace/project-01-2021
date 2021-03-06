Rails.application.routes.draw do
  resources :conversations

  resources :friendships

  resources :likes, only: [:new, :show, :destroy]
  resources :posts, only: [:index, :show, :new, :destroy]
  resources :messages, only: [:new, :index]

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [:show] do
    resources :posts
    resources :likes
  end

  resources :friendships do
    resources :conversations
  end

  post "/messages" => "messages#create", as: "create_message"

  root to: 'welcome#index'
end
