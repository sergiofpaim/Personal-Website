class ApplicationController < ActionController::API
  before_action :authenticate_request

  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  rescue_from ActionController::UnpermittedParameters, with: :handle_unpermitted_parameters
  rescue_from ActionController::BadRequest, with: :handle_bad_request

  def current_user
    @current_user
  end

  def current_token
    @current_token
  end

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

  def handle_parameter_missing(exception)
    render json: ::ResponseType.bad_request("Required parameter missing: #{exception.param}")
  end

  def handle_unpermitted_parameters(exception)
    render json: ::ResponseType.bad_request("Unpermitted parameters: #{exception.params.join(', ')}")
  end

  def handle_bad_request(exception)
    render json: ::ResponseType.bad_request(exception.message)
  end
end
