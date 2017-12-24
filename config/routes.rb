Rails.application.routes.draw do
  scope :api do
    resources :users
    post :login, to: "users#login"
    get :logout, to: "users#logout"

    resources :collections
  end
end
