Rails.application.routes.draw do
  resources :users, only: :index do
    collection do
      get :http_request
    end
  end
end