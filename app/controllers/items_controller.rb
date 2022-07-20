class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /users/:user_id/items
  # OR GET /items
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  # GET /users/:user_id/items/:id
  def show
    item = Item.find(params[:id])
    render json: item
  end

  # POST /users/:user_id/items
  def create
    user = User.find(params[:user_id])
    new_item = Item.create(item_params)
    render json: new_item, status: :created
  end


  private

  def render_not_found_response
    render json: { error: "Review not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
end
