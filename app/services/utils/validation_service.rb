module Utils
  class ValidationService
    def initialize(request)
      @request = request
    end

    def auth_header
      @request.headers["Authorization"]
    end

    def token
      return nil unless auth_header.present?
      auth_header.split(" ").last
    end

    def authenticate
      session = Session.find_by(access_token: token)
      return ::ResponseType.unauthorized("Token not found") unless session

      decoded = Utils::JwtService.decode(token)
      return ::ResponseType.unauthorized("Invalid token") if decoded.nil?

      user = User.find_by(id: decoded["sub"])
      return ::ResponseType.no_content("User not found") if user.nil?

      ::ResponseType.success({ user: user, token: token })

    rescue JWT::ExpiredSignature
      Session.where(access_token: token).destroy_all
      ::ResponseType.unauthorized("Token expired")
    rescue StandardError => e
      ::ResponseType.error("Validation error: #{e.message}")
    end
  end
end
