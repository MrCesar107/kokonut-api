# frozen_string_literal: true

class AuthenticateUser # :nodoc:
  prepend SimpleCommand

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: api_user.id) if api_user
  end

  private

  def api_user
    user = User.find_by email: email

    errors.add message: 'Invalid credentials' unless user.present? && user.valid_password?(password)

    user
  end
end
