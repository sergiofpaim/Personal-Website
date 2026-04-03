require "jwt"

module Utils
  class JwtService
    ALGORITHM = "HS256"

    def self.secret_key
      Rails.application.credentials.dig(:jwt, :secret_key)
    end

    def self.encode(user)
      payload = {
        sub: user.id,
        role: user.role,
        exp: 24.hours.from_now.to_i
      }

      JWT.encode(payload, secret_key, ALGORITHM)
    end

    def self.decode(token)
      decoded = JWT.decode(token, secret_key, true, { algorithm: ALGORITHM })
      decoded.first
    end
  end
end
