Rails.application.routes.draw do
  root 'welcome#index'

  resources :books, except: :destroy
  resources :finished_books
  resources :genres
end
