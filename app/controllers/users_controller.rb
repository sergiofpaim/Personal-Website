class UsersController < ApplicationController
  before_action do
    @service = UserService.new
  end

  before_action :require_admin, only: [ :create_user, :set_as_admin, :destroy_user ]

  # Gets all users
  def get_all_user_profiles
    users = @service.get_all_user_profiles()

    render json: users
  end

  # Gets a user
  def get_user_profile
    user = @service.get_user_profile(params[:nickname])

    render json: user
  end

  # Gets me
  def get_me
    user = @service.get_my_profile(current_user.id)

    render json: user
  end

  # Updates me
  def update_me
    user = @service.update_user(current_user.id, update_user_params)

    render json: user
  end

  # Deletes me
  def destroy_me
    result = @service.delete_me(current_user.id)

    render json: result
  end

  # ADMIN

  # Adds a user
  def create_user
    user = @service.create_user(create_user_params)

    render json: user
  end

  # Sets a user as admin
  def set_as_admin
    user = UserService.new.set_as_admin(params[:nickname])

    render json: user
  end

  def destroy_user
    result = @service.delete_user(params[:nickname])

    render json: result
  end

  # Request Params
  private
    def create_user_params
        user = params.require(:user)

        user.require(:nickname)
        user.require(:password)

        user.permit(:nickname, :password, :picture, :role)
    end

    def update_user_params
      params.require(:user).permit(:nickname, :password, :picture)
    end

    def require_admin
      render json: { error: "Access denied" }, status: :forbidden unless current_user.role.include?("admin")
    end
end
