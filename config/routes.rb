Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:index, :show, :edit, :update]  do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :questions, :controller => 'user_questions'
    member do
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users
    resources :posts
    root "posts#index"
  end

  resources :posts, :only => [:index, :show]

  resources :regs, :only => [:create]

  get 'invitations', to: 'invitations#generate'
  get 'invitations/:invite_token', to: 'invitations#check'
  #post 'invitations/:invite_token/invited_registration', to: 'invitations#invited_registration'
  root "pages#index"
  get 'pages/index' => 'pages#index'

end
