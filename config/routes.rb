Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get '/messages' => 'google_api#messages'
end
