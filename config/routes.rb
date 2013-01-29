Storyboard::Application.routes.draw do
  
  resources :users do
    member do
      get :publishers, :readers, :library_stories, :boards
    end
  end
  
  resources :stories do
    member do
      put :upvote, :downvote, :no_vote
    end
  end
  
  resources :sessions,        only: [:new, :create, :destroy]
  resources :genres
  resources :relationships,   only: [:create, :destroy]
  resources :comments,        only: [:create, :destroy]
  resources :boards,          only: [:create, :destroy]
  resources :stats,           only: [:create]
  
  root to: 'browse_pages#home'
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  
  match '/library', to: 'users#show'
  
  

  match '/write',     to: 'stories#new' 
  match '/:id',       to: 'stories#show'
  #match '/:id/edit',  to: 'stories#edit'

end
