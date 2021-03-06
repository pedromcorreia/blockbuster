# frozen_string_literal: true

Rails.application.routes.draw do
  resources :seasons, only: %i[show index]
  resources :movies, only: %i[show index]
  resources :users do
    resources :purchases
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
