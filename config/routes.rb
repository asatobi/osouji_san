# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  resources :users
  resources :cleaning_places do
    collection do
      get 'shuffle'
    end
  end
end
