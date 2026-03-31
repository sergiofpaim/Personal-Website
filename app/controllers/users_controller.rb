class UsersController < ApplicationController
  # GET /users
  # Mostrar todos os usuários 
  def index
    users = UserService.get_all_users()

    render json: users
  end

  # GET /users/{user_id}
  # Mostrar um usuario
  def show
    user = UserService.get_user(params[:id])

    render json: user
  end

  # POST /users
  # Adiciona um usuário
  def create
    user = UserService.create_user(user_params)

    render json: user, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  # Request Params
  private
    def user_params
      params.expect(user: [ :nickname, :password, :picture, :role, :createdAt, :datetime ])
    end
end
