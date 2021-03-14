# frozen_string_literal: true

module Passwords
  # The user tries to reset a password but provides an unknown email.
  class EmailNotFoundError < ActiveModelSerializers::Model
    def code
      7006
    end

    def message
      'Email not found'
    end
  end
end
