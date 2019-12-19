Rails.application.routes.draw do
  resources :blogs do
    collection do
      post :confirm
    end
  end
  get 'session/new'
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy, :show]
end
