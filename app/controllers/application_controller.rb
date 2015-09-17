##
# Class: base controller
#
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  attr_reader :current_user
  helper_method :current_user

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

private

  def user_not_authorized
    render json: { message: 'You are not authorized to perform this action.' }, status: 401
  end

protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      @current_user = User.find_by(auth_token: token)
    end
  end

  def render_unauthorized
    render json: { message: 'Token is wrong. Try again.' }, status: 401
  end
end
