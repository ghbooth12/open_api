Rails.application.routes.draw do
  # namespace separtes the API routes from the rest of the application routes.
  # `defaults: { format: :json } tells the route to support requests in JSON form.`
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
