Rails.application.routes.draw do
  root to: "search#new"
  get "/search", to: "search#show"
  resources :senkyokus, only: [:index, :show]
  resources :candidates, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html




  get '*path', controller: 'application', action: 'render_404'
end
