class Api::ListsController < ApiController
  before_action :authenticated?
  before_action :set_user
  before_action :authorized_user?, only: [:create, :destroy, :update]

  def index
    lists = @user.lists.visible(@current_user, @user)
    render json: lists
  end

  def create
    list = @user.lists.build(list_params)

    if list.save
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      list = @user.lists.find(params[:id])
      list.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end
  end

  def update
    list = @user.lists.find(params[:id])

    if list.update_attributes(list_params)
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    begin
      list = @user.lists.visible(@current_user, @user).find(params[:id])
      render json: list
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def list_params
    params.require(:list).permit(:title, :private)
  end

  # only: [:create, :destroy, :update]
  def authorized_user?
    unless @current_user == @user
      render json: { error: "Authorized User Only" }, status: :unauthorized
    end
  end
end
