Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users do
        post 'sign_in', on: :collection
        post 'sign_out', on: :collection
      end
      resources :events
      resources :items
    end
  end
end
