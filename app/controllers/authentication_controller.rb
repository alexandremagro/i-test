class AuthenticationController < ActionController::API
  include ActionController::MimeResponds
  before_action :configure_permitted_parameters

  respond_to :json

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
