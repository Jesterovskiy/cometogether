##
# Class: Items controller
#
class API::V1::ItemsController < ApplicationController
  before_action :authenticate

  def index
    items = Item.all
    authorize items

    render json: ItemsListPresenter.new(items), status: 200
  end

  def show
    item = Item.find_by(id: params['id'])

    if item
      authorize item
      render json: ItemPresenter.new(item), status: 200
    else
      render json: ItemPresenter.new(error: 'Resource not found', status: 404), status: 404
    end
  end

  def create
    item = Item.new(item_params)
    authorize item

    if item.valid?
      item.save
      render json: ItemPresenter.new(item), status: 200
    else
      render json: ItemPresenter.new(error: item.errors, status: 400), status: 400
    end
  end

  def update
    if item = Item.find_by(id: params['id'])
      authorize item
      if item.update(item_params)
        render json: ItemPresenter.new(item), status: 200
      else
        render json: ItemPresenter.new(error: item.errors, status: 400), status: 400
      end
    else
      render json: ItemPresenter.new(error: 'Resource not found', status: 404), status: 404
    end
  end

  def destroy
    item = Item.find_by(id: params['id'])

    if item
      authorize item
      item.delete
      render json: ItemPresenter.new(item), status: 200
    else
      render json: ItemPresenter.new(error: 'Resource not found', status: 404), status: 404
    end
  end

private

  def item_params
    params.require(:item).permit(:description, :comment, :event_id)
  end
end
