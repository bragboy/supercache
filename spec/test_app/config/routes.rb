Rails.application.routes.draw do
  resources :users, only: :index do
    collection do
      get :http_request
      get :add_to_sql_exception
      get :add_to_http_exception
    end
  end
end