class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_customer

  private

  def set_customer
    @current_customer = Customer.first
  end
end
