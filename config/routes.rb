# frozen_string_literal: true

Rails.application.routes.draw do
  resources :articles, only: %i[index show]
  post 'login', to: 'access_tokens#create'
end
