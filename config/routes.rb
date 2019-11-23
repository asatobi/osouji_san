# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  resources :users
  resources :cleaning_places do
    collection do
      get 'shuffle'
      get 'send_to_matermost'
    end
  end
end
