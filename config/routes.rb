Pigbank::Application.routes.draw do

  devise_for :users

  resource :deposit, :only => [:new, :create] do
    post :check
  end

  resource :withdraw, :only => [:new, :create] do
    post :check
  end

  resource :balance, :only => [:show]

  root 'home#index'

end
