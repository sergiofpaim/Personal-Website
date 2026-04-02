class UsersController < ApplicationController
  # Gets all users
  def index
    users = UserService.get_all_users()

    render json: users
  end

  # Shows a user
  def show
    user = UserService.get_user(params[:id])

    render json: user
  end

  # Adds a user
  def create
    user = UserService.create_user(create_user_params)

    render json: user
  end

  # Updates a user
  def update
    user = UserService.update_user(params[:id], update_user_params)

    render json: user
  end

  # Deletes a user
  def destroy
    result = UserService.delete_user(params[:id])

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
