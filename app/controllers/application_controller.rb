class ApplicationController < ActionController::Base
  before_action :verify_authenticity_token
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller? #About login function
  before_action :cors_preflight_check

  protect_from_forgery with: :exception

  include ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: 'Access Denied'
  end

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  # You want to get exceptions in development, but not in production.
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: -> { render_404 }
  end
  rescue_from AbstractController::ActionNotFound, with: -> { render_404 }

  layout :layout

  private

  def layout
    # only turn it off for login pages:
    is_a?(Devise::SessionsController) ? "login" : "application"
    # or turn layout off for every devise controller:
  end

  def render_404
    respond_to do |format|
      format.html { render template: 'pages/not_found_error', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :password])
  end
end
