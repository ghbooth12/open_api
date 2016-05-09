class Api::UsersController < ApiController
  before_action :authenticated?

  def index
    users = User.all
    render json: users, each_serializer: UserSerializer
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity    # 422
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy
      render json: {}, status: :no_content   # 204
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found    # 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
