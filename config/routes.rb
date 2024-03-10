Rails.application.routes.draw do
  root to: "pages#home"
  get '/:locale', to: "pages#home"

  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: { invitations: 'users/invitations' }

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check

    resources :families do
      get '/invite', to: 'families#invite'
      resources :lists, only: %i[index new create]
      resources :recipes, only: %i[index new create edit update]
    end

    resources :lists, only: %i[show destroy] do
      resources :list_items, only: %i[create]
    end
    resources :list_items, only: %i[update destroy]

    resources :recipes, only: %i[show destroy] do
      resources :categories, only: %i[new create]
    end
  end
end
