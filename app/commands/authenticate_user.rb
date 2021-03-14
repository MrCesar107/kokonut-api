# frozen_string_literal: true

class AuthenticateUser # :nodoc:
  prepend SimpleCommand

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    if valid?
      auth_token = JsonWebToken.encode(user_id: api_user.id)
      api_user.update auth_token: auth_token
      api_user
    else
      errors.add(:message, 'Invalid credentials')
    end
  end

  private

  def api_user
    @api_user ||= User.find_by email: email
  end

  def passwords_match
    api_user &&
      Devise::Encryptor.compare(api_user.class, api_user.encrypted_password,
                                password)
  end

  def valid?
    !api_user.nil? && passwords_match
  end
end
