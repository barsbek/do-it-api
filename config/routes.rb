Rails.application.routes.draw do
  scope :api do
    resources :users
    post :login, to: "users#login"
    delete :logout, to: "users#logout"
    get :current_user, to: "users#show"

    resources :collections
    resources :lists
    get '/lists/:id/tasks', to: "lists#tasks"
    resources :tasks
  end
end
