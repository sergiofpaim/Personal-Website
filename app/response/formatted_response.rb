class FormattedResponse
  attr_reader :status_code, :message, :payload

  def initialize(status_code:, message:, payload: nil)
    @status_code = status_code
    @message = message
    @payload = payload
  end

  def success?
    status_code >= 200 && status_code < 300
  end

  def error?
    !success?
  end

  # Overrides the json render function and formats its structure
  def as_json(*)
    {
      status_code: status_code,
      message: message,
      payload: payload
    }
  end
end
