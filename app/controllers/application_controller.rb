class ApplicationController < ActionController::Base
  around_action :switch_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  include Pundit::Authorization

  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birth_date])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :birth_date])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :birth_date, :family_ids])
    devise_parameter_sanitizer.permit(:invite, keys: [:name, :birth_date, :family_ids])
  end
end
