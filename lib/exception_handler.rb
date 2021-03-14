# frozen_string_literal: true

# JWT exceptions handler module
module ExceptionHandler
  extend ActiveSupport::Concern

  class DecodeError < StandardError; end

  class ExpiredSignature < StandardError; end

  included do
    rescue_from ExceptionHandler::DecodeError do |_error|
      render json: { message: 'Invalid token' }, status: :unauthorized
    end

    rescue_from ExceptionHandler::ExpiredSignature do |_error|
      render json: { message: 'Token has expired' }, status: :unauthorized
    end
  end
end
