##
# Class: Items controller
#
class API::V1::ItemsController < ApplicationController
  def index
    render json: ItemsListPresenter.new, status: 200
  end

  def show
    if item = Item.find_by(id: params['id'])
      render json: ItemPresenter.new(item), status: 200
    else
      render json: { message: 'Resource not found' }, status: 404
    end
  end

  def create
    item = Item.create(item_params)

    if item.valid?
      render json: ItemPresenter.new(item), status: 200
    else
      render json: { message: item.errors }, status: 400
    end
  end

  def update
    if item = Item.find_by(id: params['id'])
      if item.update(item_params)
        render json: ItemPresenter.new(item), status: 200
      else
        render json: { message: item.errors }, status: 400
      end
    else
      render json: { message: 'Resource not found' }, status: 404
    end
  end

  def destroy
    unless Item.delete(params['id']) == 0
      render json: { message: 'Resource deleted' }, status: 200
    else
      render json: { message: 'Resource not found' }, status: 404
    end
  end

private

  def item_params
    params.require(:item).permit(:description, :comment, :event_id)
  end
end
