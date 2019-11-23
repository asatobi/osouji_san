Rails.application.routes.draw do
  root to: 'home#index'
  get 'cleaning_places/shuffle'
  resources :users

end
