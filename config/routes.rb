Rails.application.routes.draw do
  get 'search', to: 'search#index', as: 'search_index'
end
