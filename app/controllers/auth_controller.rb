class AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [ :login, :register ]

  before_action do
    @service = AuthService.new()
  end

  # Registers a user
  def register
    register = @service.register(auth_params)

    render json: register
  end

  # Signs a user in
  def login
    login = @service.login(auth_params)

    render json: login
  end


  # Signs a user out
  def logout
    @service.logout(@current_token)
  end

  # Request Params
  private
  def auth_params
    register = params.require(:auth)

    register.require(:nickname)
    register.require(:password)

    register.permit(:nickname, :password)
  end
end
