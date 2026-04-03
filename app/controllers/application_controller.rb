class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def auth_header
    request.headers["Authorization"]
  end

  def token
    return nil unless auth_header.present?

    auth_header.split(" ").last
  end

  def authenticate_request
    render json: { error: "Token not found" } unless Session.find_by(access_token: token)

    decoded_token = Utils::JwtService.decode(token)

    if decoded_token.nil?
      render json: { error: "Invalid token" }, status: :unauthorized
      return
    end

    @current_user = User.find_by(id: decoded_token["sub"])
    @current_token = token

    if @current_user.nil?
      render json: { error: "Usuário não encontrado" }, status: :unauthorized
    end

  rescue JWT::ExpiredSignature
      Session.where(access_token: token).destroy_all
      render json: { error: "Token expired" }, status: :unauthorized
  end

  def current_user
    @current_user
  end

  def current_token
    @current_token
  end
end
