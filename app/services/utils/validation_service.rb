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
      return { error: "Token not found", status: :unauthorized } unless session

      decoded = Utils::JwtService.decode(token)
      return { error: "Invalid token", status: :unauthorized } if decoded.nil?

      user = User.find_by(id: decoded["sub"])
      return { error: "Usuário não encontrado", status: :unauthorized } if user.nil?

      { user: user, token: token }
    rescue JWT::ExpiredSignature
      Session.where(access_token: token).destroy_all
      { error: "Token expired", status: :unauthorized }
    end
  end
end
