# frozen_string_literal: true

class JsonWebToken # :nodoc:
  def self.decode(token)
    secret_key_base = Rails.application.secrets.secret_key_base
    body = JWT.decode(token, secret_key_base)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::ExpiredSignature => e
    raise ExceptionHandler::ExpiredSignature, e.message
  rescue JWT::DecodeError, JWT::VerificationError => e
    raise ExceptionHandler::DecodeError, e.message
  end

  def self.encode(payload, expires_at = 24.hours.from_now)
    payload[:expires_at] = expires_at.to_i
    secret_key_base = Rails.application.secrets.secret_key_base
    JWT.encode payload, secret_key_base
  end
end
