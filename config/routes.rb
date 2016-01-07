Rails.application.routes.draw do
  root 'welcome#index'

  resources :books, only: [:index, :create, :destroy]
  resources :finished_books, only: :index
  resources :genres, only: :index
end
