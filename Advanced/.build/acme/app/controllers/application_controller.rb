class ApplicationController < ActionController::Base
  include CurrentCart

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
  rescue_from ActionController::ParameterMissing, with: :handle_missing_parameter
  rescue_from CanCan::AccessDenied, with: :handle_access_denied

  protected

  def after_sign_in_path_for(_resource)
    products_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    products_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio])
  end

  def handle_not_found
    redirect_to products_path, alert: "La ressource demandee est introuvable."
  end

  def handle_invalid_record(error)
    redirect_back fallback_location: products_path, alert: error.record.errors.full_messages.to_sentence
  end

  def handle_missing_parameter(error)
    redirect_back fallback_location: products_path, alert: "Parametre manquant : #{error.param}."
  end

  def handle_access_denied
    redirect_to products_path, alert: "Vous n'avez pas les droits necessaires pour cette action."
  end
end
