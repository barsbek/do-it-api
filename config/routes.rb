Rails.application.routes.draw do
  resources :lists
  scope :api do
    resources :users
    post :login, to: "users#login"
    delete :logout, to: "users#logout"
    get :current_user, to: "users#current"

    resources :collections
  end
end
