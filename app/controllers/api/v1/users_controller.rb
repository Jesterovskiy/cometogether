##
# Class: Users controller
#
class API::V1::UsersController < ApplicationController
  def index
    render json: UsersListPresenter.new, status: 200
  end

  def show
    if user = User.find_by(id: params['id'])
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
    if user = User.find_by(id: params['id'])
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
    unless User.delete(params['id']) == 0
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
