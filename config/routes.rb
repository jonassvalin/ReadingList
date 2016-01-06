Rails.application.routes.draw do
  root 'welcome#index'

  resources :books
  resources :finished_books
  resources :genres
end
