Rails.application.routes.draw do
  resources :users do
    collection do
      get :search
    end
  end
end
