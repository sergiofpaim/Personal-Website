class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    result = Utils::ValidationService.new(request).authenticate

    unless result.success?
      render json: result
      return
    end

    @current_user = result.payload[:user]
    @current_token = result.payload[:token]
  end

  def current_user
    @current_user
  end

  def current_token
    @current_token
  end
end
