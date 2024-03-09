# frozen_string_literal: true

Rails.application.routes.draw do
  resources :movies

  # Root route
  root 'movies#index'
end
