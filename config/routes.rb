Storyboard::Application.routes.draw do
  resources :users do
    member do
      get :publishers, :readers, :library_stories
    end
  end
  resources :sessions,        only: [:new, :create, :destroy]
  resources :stories do
    resources :comments,        only: [:create, :destroy]
  end
  resources :relationships,   only: [:create, :destroy]
  resources :boards,          only: [:create, :destroy]
  resources :stats,           only: [:create]
  
  root to: 'users#index'
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  

  match '/write',     to: 'stories#new' 
  #match '/:id',       to: 'stories#show'
  #match '/:id/edit',  to: 'stories#edit'

end
