# frozen_string_literal: true

Rails.application.routes.draw do
  resources :articles
  post 'login', to: 'access_tokens#create'
  delete 'logout', to: 'access_tokens#destroy'
end
