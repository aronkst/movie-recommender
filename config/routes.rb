Rails.application.routes.draw do
  root 'recommended_movies#index'
  get 'search', to: 'search#index', as: 'search_index'
  post 'state/:imdb', to: 'states#upsert', as: 'states_upsert'
  get ':state', to: 'states#index', as: 'states_index'
end
