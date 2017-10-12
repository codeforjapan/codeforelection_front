Rails.application.routes.draw do
  root to: "search#new"
  get "/search", to: "search#show"
  get "/search_by_name", to: "search#by_name"
  get '/senkyoku/:pref_code', to: 'prefs#show'
  get '/senkyoku/:pref_code/:senkyoku_no', to: 'senkyokus#show'

  resources :candidates, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # components index page
  get "/index", to: "search#index"

  get '*path', controller: 'application', action: 'render_404'
end
