Rails.application.routes.draw do
  resources :users

  post :login, to: "users#login"
  get :logout, to: "users#logout"
end
