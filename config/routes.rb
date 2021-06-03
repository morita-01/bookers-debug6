Rails.application.routes.draw do

  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :books do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   resource :favorite, only: [:create, :destroy]
   resource :book_comment, only: [:create]
  end
  resources :book_comments, only: [:destroy]
  resources :users, only: [:show, :edit, :update, :index]
end
