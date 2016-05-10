Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index, :create, :destroy, :update] do
      resources :lists, only: [:index, :create, :destroy, :update, :show]
    end

    resources :lists, only: [] do
      resources :items, only: [:index, :create, :destroy, :update]
    end
  end

  root 'welcome#index'
end
