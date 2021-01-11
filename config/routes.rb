Rails.application.routes.draw do
  resources :posts
  devise_for :users

  resources :users do
    resources :posts
  end

  root to: 'welcome#index'
end
