Rails.application.routes.draw do
  root 'welcome#index'

  resources :books, only: :index
  resources :finished_books
  resources :genres
end
