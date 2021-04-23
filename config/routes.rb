Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    get '/users', to: 'users#index'
    get '/user/:id', to: 'users#show'
    post '/user', to: 'users#create'
    put '/user/:id', to: 'users#update'
    delete '/user/:id', to: 'users#destroy'
    get '/typeahead/:input', to: 'users#typeahead'
  end
end
