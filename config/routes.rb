T4c::Application.routes.draw do

  root 'home#index'

  get 'audit' => 'home#audit'
  get 'faq' => 'home#faq'

  devise_for :users,
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "registrations",
    }

  resources :users, :only => [:show, :update, :index] do
    collection do
      get :login
    end
    member do
      post :send_tips_back
      post :send_email_address_request
      get :set_password_and_address
      patch :set_password_and_address
    end
  end
  resources :projects, :only => [:new, :show, :index, :create, :edit, :update] do
    resources :tips, :only => [:index]
    resources :distributions, :only => [:new, :create, :show, :index, :edit, :update] do
      get :new_recipient_form, on: :collection
      post :send_transaction, on: :member
    end
    member do
      get :qrcode
      get :decide_tip_amounts
      patch :decide_tip_amounts
      get :commit_suggestions
      get :github_user_suggestions
    end
  end
  resources :tips, :only => [:index]
  resources :distributions, :only => [:index]
end
