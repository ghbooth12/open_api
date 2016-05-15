class Api::ItemsController < ApiController
  before_action :authenticated?
  before_action :set_list
  before_action :authorized_user?, only: [:create, :destroy, :update]

  def index
    items = @list.items
    render json: items
  end

  def create
    item = @list.items.build(item_params)
    item.user_id = @current_user.id

    if item.save
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      item = @list.items.find(params[:id])
      item.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end
  end

  def update
    item = @list.items.find(params[:id])

    if item.update_attributes(item_params)
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_list
    begin
      list = List.find(params[:list_id])
      visible_lists = List.visible(@current_user, list.user)
      @list = visible_lists.find(params[:list_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Not Found" }, status: :not_found
    end
  end

  def item_params
    params.require(:item).permit(:description, :completed)
  end

  # only: [:create, :destroy, :update]
  def authorized_user?
    unless @current_user == @list.user
      render json: { error: "Authorized User Only" }, status: :unauthorized
    end
  end
end
