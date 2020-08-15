Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  devise_for :users, :controllers => { sessions: "sessions", registrations: "registrations" }

  resources :notes
  resources :note_collaborators

  root to: "notes#index"
end
