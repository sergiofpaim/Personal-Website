class ResponseType
  def self.success(payload, message = "Success")
    FormattedResponse.new(status_code: 200, message: message, payload: payload)
  end

  def self.bad_request(message = "Bad request")
    FormattedResponse.new(status_code: 400, message: message, payload: nil)
  end

  def self.conflict(message = "Conflict")
    FormattedResponse.new(status_code: 409, message: message, payload: nil)
  end

  def self.unauthorized(message = "Unauthorized")
    FormattedResponse.new(status_code: 401, message: message, payload: nil)
  end

  def self.forbidden(message = "Forbidden")
    FormattedResponse.new(status_code: 403, message: message, payload: nil)
  end

  def self.no_content(message = "No content")
    FormattedResponse.new(status_code: 204, message: message, payload: nil)
  end

  def self.error(message = "Error")
    FormattedResponse.new(status_code: 500, message: message, payload: nil)
  end
end
