##
# Class: Users controller
#
class API::V1::UsersController < ApplicationController
  before_action :authenticate, except: [:sign_in, :create]

  def sign_in
    user = User.find_by_email(user_params['email'])
    if user && user.authenticate(user_params['password'])
      render json: { message: 'Your auth token is ' + user.auth_token }, status: 200
    else
      render json: { message: 'Email or password is wrong. Try again.' }, status: 401
    end
  end

  def index
    users = User.all
    authorize users
    render json: UsersListPresenter.new(users), status: 200
  end

  def show
    user = User.find_by(id: params['id'])
    if user
      authorize user
      render json: UserPresenter.new(user), status: 200
    else
      render json: { message: 'Resource not found' }, status: 404
    end
  end

  def create
    user = User.create(user_params)

    if user.valid?
      render json: UserPresenter.new(user), status: 200
    else
      render json: { message: user.errors }, status: 400
    end
  end

  def update
    user = User.find_by(id: params['id'])

    if user
      authorize user
      if user.update(user_params)
        render json: UserPresenter.new(user), status: 200
      else
        render json: { message: user.errors }, status: 400
      end
    else
      render json: { message: 'Resource not found' }, status: 404
    end
  end

  def destroy
    user = User.find_by(id: params['id'])

    if user
      authorize user
      user.delete
      render json: { message: 'Resource deleted' }, status: 200
    else
      render json: { message: 'Resource not found' }, status: 404
    end
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :role)
  end
end
