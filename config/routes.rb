Rails.application.routes.draw do
  resources :indicators do
    collection do
      get :latest
    end
  end
end
