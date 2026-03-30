class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # POST /users
  def create
    user = UserService.createUser(user_params)

    render json: user
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :nickname, :password, :picture, :role, :createdAt, :datetime ])
    end
end
