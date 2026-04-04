class ApplicationController < ActionController::API
  # TODO: Adicionar tratamento de erro persolanizado
  # TODO: Criar painel de admin

  before_action :authenticate_request

  private

  def authenticate_request
    result = Utils::ValidationService.new(request).authenticate

    if result[:error]
      render json: { error: result[:error] }, status: result[:status]
      return
    end

    @current_user = result[:user]
    @current_token = result[:token]
  end

  def current_user
    @current_user
  end

  def current_token
    @current_token
  end
end
