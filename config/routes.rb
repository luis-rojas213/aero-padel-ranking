Rails.application.routes.draw do
  root 'rankings#index'
  resources :rankings
  resources :plays
  resources :pairs
  resources :players
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'pairs_add', to: 'pairs#add'
  post 'pairs_generate', to: 'pairs#generate'
  get 'clean_ranking', to: 'rankings#clean'
end
