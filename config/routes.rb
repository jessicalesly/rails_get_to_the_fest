Rails.application.routes.draw do
  get '/results', to: 'matches#results', as: :match_path
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :festivals, only: [:show]
  # get '/auth/spotify/callback', to: 'users#spotify'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
