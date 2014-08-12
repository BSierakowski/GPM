Gpm::Application.routes.draw do
  resources :player

  root 'player#new'
  get 'player/:id' => 'player#show'
  post 'player/search' => 'player#search'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
