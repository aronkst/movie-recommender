Rails.application.routes.draw do
  get 'search', to: 'search#index', as: 'search_index'
  post 'state/:imdb', to: 'states#upsert', as: 'states_upsert'
end
