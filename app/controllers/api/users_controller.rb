class Api::UsersController < ApiController
  before_action :authenticated? # check if user is a member or a guest.
  before_action :authorized_user?, only: [:destroy, :update] # only user him/herself can update, destroy.

  # This returns a UserSerializer-generated JSON representation of all users.
  def index
    users = User.all
    render json: users, each_serializer: UserSerializer
  end

  def create
    user = User.new(user_params)
    if user.save
      # Rails searches for UserSerializer and use it to serialize "user".
      render json: user
    else
      # 422 Unprocessable Entity (the data sent was un-processable)
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy
      
      # 204 No Content to indicate (the server successfully processed the request)
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found    # 404
    end
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  # only: [:destroy, :update]
  # @current_user = User.where(email: email, password: password).first
  def authorized_user?
    user = User.find(params[:id])
    unless @current_user == user
      render json: { error: "Authorized User Only" }, status: :unauthorized
    end
  end
end
