Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:index, :show, :edit, :update]  do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    member do
      get :coupon
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root "pages#index"

end
