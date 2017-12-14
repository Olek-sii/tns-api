Rails.application.routes.draw do
  resources :messages, only: [:index, :show, :update]
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
  }
end
