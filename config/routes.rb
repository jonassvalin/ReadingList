Rails.application.routes.draw do
  root to: 'welcome#index'

  namespace :api do
    resources :books, only: [:index, :create, :destroy]
    resources :finished_books, only: :index
    resources :genres, only: :index
  end

end
