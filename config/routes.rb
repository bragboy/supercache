Supercache::Engine.routes.draw do
  root to: "dashboard#index"

  resources :dashboard, only: [:index] do
    collection do
      get :flip
      get :add_to_sql_exception, as: :sql_exception
      get :add_to_http_exception, as: :http_exception
    end
  end
end
