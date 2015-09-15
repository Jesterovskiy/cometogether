##
# Class: Events controller
#
class API::V1::EventsController < ApplicationController
  def index
    render json: EventsListPresenter.new, status: 200
  end

  def show
    if event = Event.find_by(id: params['id'])
      render json: EventPresenter.new(event), status: 200
    else
      render json: { message: 'Resource not found' }, status: 404
    end
  end

  def create
    event = Event.create(event_params)

    if event.valid?
      render json: EventPresenter.new(event), status: 200
    else
      render json: { message: event.errors }, status: 400
    end
  end

  def update
    if event = Event.find_by(id: params['id'])
      if event.update(event_params)
        render json: EventPresenter.new(event), status: 200
      else
        render json: { message: event.errors }, status: 400
      end
    else
      render json: { message: 'Resource not found' }, status: 404
    end
  end

  def destroy
    if Event.delete(params['id']) != 0
      render json: { message: 'Resource deleted' }, status: 200
    else
      render json: { message: 'Resource not found' }, status: 404
    end
  end

private

  def event_params
    params.require(:event).permit(:name, :description, :location, :date, :user_id)
  end
end
