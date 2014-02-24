Pigbank::Application.routes.draw do

  devise_for :users

  resources :deposits, :only => [:new, :create, :show] do
    post :check, :on => :collection
  end

  resources :withdraws, :only => [:new, :create, :show] do
    post :check, :on => :collection
  end

  resources :transferences, :only => [:new, :create, :show] do
    post :check, :on => :collection
  end

  resource :balance, :only => [:show]

  resource :statement, :only => [:new, :show]

  root 'home#index'

end
