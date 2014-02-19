Pigbank::Application.routes.draw do

  devise_for :users

  resource :deposit, :only => [:new, :create] do
    post :check
  end

  root 'home#index'

end
