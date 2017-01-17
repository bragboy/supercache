Supercache::Engine.routes.draw do
  root to: "dashboard#index"

  resources :dashboard, only: [:index] do
    collection do
      get :flip
      post :except_list
    end
  end
end
