# frozen_string_literal: true

class AuthorizeApiRequest # :nodoc:
  prepend SimpleCommand

  attr_reader :headers

  def initialize(headers = {})
    @headers = headers
  end

  def call
    return errors.add(token: 'Invalid token') unless user.nil?

    user
  end

  private

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    errors.add(token: 'Missing token') unless headers['Authorization'].present?

    headers['Authorization'].split(' ').last
  end
end
