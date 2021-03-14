# frozen_string_literal: true

class AuthorizeApiRequest # :nodoc:
  prepend SimpleCommand

  attr_reader :headers

  def initialize(headers = {})
    @headers = headers
  end

  def call
    errors.add(:error, 'Invalid token') if user.nil?

    user
  end

  private

  def user
    @user ||= User.find_by(id: decoded_auth_token[:user_id])
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    errors.add(token: 'Missing token') unless headers['Authorization'].present?

    headers['Authorization'].split('Token=').last
  end
end
