Rails.application.routes.draw do
  root to: "pages#home"
  get '/:locale', to: "pages#home"

  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check

    resources :families do
      resources :family_members, only: %i[create destroy]
      resources :lists, only: %i[index new create]
    end

    resources :lists, only: %i[show] do
      resources :list_items, only: %i[create]
    end
  end
end
