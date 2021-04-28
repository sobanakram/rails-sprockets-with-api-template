Rails.application.routes.draw do
  root to: "home#index"
  apipie

  devise_for :users

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      mount_devise_token_auth_for "User", at: "/users", controllers: {
        sessions: "api/v1/sessions",
        passwords: "api/v1/passwords",
        registrations: "api/v1/registrations"
      }

      get "user/profile", to: "users#profile"
      post "user/change_password", to: "users#change_password"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
