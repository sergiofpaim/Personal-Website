class UsersController < ApplicationController
  # POST /users
  def create
    user = UserService.create_user(user_params)

    render json: user, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  private
    def user_params
      params.expect(user: [ :nickname, :password, :picture, :role, :createdAt, :datetime ])
    end
end
