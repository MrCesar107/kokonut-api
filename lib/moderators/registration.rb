# frozen_string_literal: true

module Moderators
  class Registration
    include ActiveModel::Model
    attr_accessor :name, :email, :password, :password_confirmation

    validates :name, :email, :password, :password_confirmation, presence: true

    validates :password, confirmation: true

    def create_moderator
      if valid?
        moderator = Moderator.create! moderator_params
        add_token_to(moderator)
        response = RegistrationModerator.new moderator
        { moderator: moderator, status: response.http_status }
      else
        error = RegistrationError.new self
        { message: error.message, status: error.http_status }
      end
    rescue ActiveRecord::RecordInvalid => e
      error = RegistrationError.new e.record
      { message: error.message, status: error.http_status }
    end

    private

    def add_token_to(moderator)
      auth_token = JsonWebToken.encode(moderator_id: moderator.id)
      moderator.update auth_token: auth_token
    end

    def moderator_params
      { name: name, email: email, password: password,
        password_confirmation: password_confirmation }
    end
  end
end
