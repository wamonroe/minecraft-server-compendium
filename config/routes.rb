Rails.application.routes.draw do
  root to: 'servers#index'

  # For now we are disabling registrations, but using part of the controller for account profiles.
  devise_for :users,
    controllers: {
      confirmations: 'users/confirmations',
      invitations: 'users/invitations',
      passwords: 'users/passwords',
      sessions: 'users/sessions',
      unlocks: 'users/unlocks'
    },
    skip: %i[omniauth_callbacks registrations]

  devise_scope :user do
    get 'users/edit', to: 'users/registrations#edit', as: 'edit_user_registration'
    put 'users', to: 'users/registrations#update', as: 'user_registration'
  end

  resources :locations, except: %i[index]
  resources :servers
end
