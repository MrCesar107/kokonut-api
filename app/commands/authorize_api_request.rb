# frozen_string_literal: true

class AuthorizeApiRequest # :nodoc:
  prepend SimpleCommand

  attr_reader :headers, :moderator_request

  def initialize(headers = {}, moderator_request: false)
    @headers = headers
    @moderator_request = moderator_request
  end

  def call
    errors.add(:error, 'Invalid token') if user.nil? || moderator.nil?

    return moderator if moderator_request

    user
  end

  private

  def moderator
    @moderator ||= Moderator.find_by id: decoded_auth_token[:moderator_id]
  end

  def user
    @user ||= User.find_by id: decoded_auth_token[:user_id]
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return errors.add(:error, 'Missing token') unless
      headers['Authorization'].present?

    headers['Authorization'].split('Token=').last
  end
end
