##
# Class: Events controller
#
class API::V1::EventsController < ApplicationController
  before_action :authenticate

  def index
    events = Event.all
    authorize events

    render json: ResponsePresenter.new(events), status: 200
  end

  def show
    event = Event.find_by(id: params['id'])

    if event
      authorize event
      render json: ResponsePresenter.new(event), status: 200
    else
      render json: ResponsePresenter.new(error: 'Resource not found', status: 404), status: 404
    end
  end

  def create
    event = Event.new(event_params)
    authorize event

    if event.valid?
      event.save
      render json: ResponsePresenter.new(event), status: 200
    else
      render json: ResponsePresenter.new(error: event.errors, status: 400), status: 400
    end
  end

  def update
    if event = Event.find_by(id: params['id'])
      authorize event

      if event.update(event_params)
        render json: ResponsePresenter.new(event), status: 200
      else
        render json: ResponsePresenter.new(error: event.errors, status: 400), status: 400
      end
    else
      render json: ResponsePresenter.new(error: 'Resource not found', status: 404), status: 404
    end
  end

  def destroy
    event = Event.find_by(id: params['id'])

    if event
      authorize event
      event.delete
      render json: ResponsePresenter.new(event), status: 200
    else
      render json: ResponsePresenter.new(error: 'Resource not found', status: 404), status: 404
    end
  end

private

  def event_params
    params.require(:event).permit(:name, :description, :location, :date, :user_id)
  end
end
