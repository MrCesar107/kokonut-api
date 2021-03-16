# frozen_string_literal: true

module Users
  # This class is in charge about all relationated with user registrations in DB
  class Registration
    include ActiveModel::Model
    attr_accessor :email, :name, :nickname, :password, :password_confirmation

    validates :email, :name, :nickname, :password, :password_confirmation,
              presence: true

    validates :password, confirmation: true

    def create_user
      if valid?
        user = User.create! user_params
        add_token_to(user)
        response = RegistrationUser.new user
        { user: response.to_model, status: response.http_status }
      else
        error = RegistrationError.new self
        { message: error.message, status: error.http_status }
      end
    rescue ActiveRecord::RecordInvalid => e
      error = RegistrationError.new e.record
      { message: error.message, status: error.http_status }
    end

    private

    def add_token_to(user)
      auth_token = JsonWebToken.encode(user_id: user.id)
      user.update auth_token: auth_token
    end

    def user_params
      { name: name, nickname: nickname, email: email, password: password,
        password_confirmation: password_confirmation }
    end
  end
end
