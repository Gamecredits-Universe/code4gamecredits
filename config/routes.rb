T4c::Application.routes.draw do

  root 'home#index'

  get 'audit' => 'home#audit'
  get 'faq' => 'home#faq'

  get 'login' => 'home#login'

  resources :users, :only => [:show, :update, :index] do
    collection do
      get :login
    end
    member do
      post :send_tips_back
    end
  end
  resources :projects, :only => [:new, :show, :index, :create, :edit, :update] do
    resources :tips, :only => [:index]
    member do
      get :qrcode
      get :decide_tip_amounts
      patch :decide_tip_amounts
    end
  end
  resources :tips, :only => [:index]
  resources :distributions, :only => [:index]

  devise_for :users,
    :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks"
    }
end
