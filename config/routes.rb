# frozen_string_literal: true

Rails.application.routes.draw do
  resources :articles, only: %i[index show create update]
  post 'login', to: 'access_tokens#create'
  delete 'logout', to: 'access_tokens#destroy'
end
