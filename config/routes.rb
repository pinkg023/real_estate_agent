Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:index, :show, :edit, :update]  do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    member do
      get :coupon
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users, :only => [:index]  
    resources :posts, :only => [:index, :destroy]  
    root "posts#index"
  end

  root "pages#index"
  get 'pages/index' => 'pages#index'

end
