class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def current_user
    if current_customer
      current_customer
    elsif current_admin
      current_admin
    else
      Customer.new
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name ])
  end
  private

end
