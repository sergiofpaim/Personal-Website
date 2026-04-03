class UsersController < ApplicationController
  before_action do
    authenticate_request
    @service = UserService.new
  end

  # Gets all users
  def index
    users = @service.get_all_users()

    render json: users
  end

  # Shows a user
  def show
    user = @service.get_user(params[:id])

    render json: user
  end

  # Adds a user
  def create
    user = @service.create_user(create_user_params)

    render json: user
  end

  # Updates a user
  def update
    user = @service.update_user(params[:id], update_user_params)

    render json: user
  end

  # Deletes a user
  def destroy
    result = @service.delete_user(params[:id])

    render json: result
  end

  # Request Params
  private
    def create_user_params
      user = params.require(:user)

      user.require(:nickname)
      user.require(:password)

      user.permit(:nickname, :password, :picture, :role, :createdAt)
    end

    def update_user_params
      params.require(:user).permit(:nickname, :password, :picture, :role, :createdAt)
    end
end
