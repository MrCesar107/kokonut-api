# frozen_string_literal: true

module Users
  # Created in Registration create_user to response as json
  class RegistrationUser < SimpleDelegator
    extend ActiveModel::Naming

    def initialize(user)
      super user
    end

    def to_model
      self
    end

    def http_status
      200
    end
  end
end
