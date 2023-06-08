Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  get '/admin/chats', to: 'admin/chats#load_chat_listing', as: :admin_chats_default
  ActiveAdmin.routes(self)
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :chats, only: [:create]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
