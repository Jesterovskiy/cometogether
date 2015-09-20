##
# Class: base controller
#
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_user

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

private

  def user_not_authorized
    render json: { message: 'You are not authorized to perform this action.' }, status: 401
  end

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
