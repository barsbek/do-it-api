Rails.application.routes.draw do
  scope :api do
    post :register, to: "users#create"
    post :login, to: "users#login"
    delete :logout, to: "users#logout"
    get :current_user, to: "users#show"
    put :current_user, to: "users#update"

    resources :collections
    resources :lists, except: [:index]
    get '/lists/:id/tasks', to: "lists#tasks"
    resources :tasks
  end
end
