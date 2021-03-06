# frozen_string_literal: true

module Moderators
  # This class generates the user registration errors JSON for the API response
  class RegistrationError < ActiveModelSerializers::Model
    attr_reader :registration

    def initialize(registration)
      @registration = registration
    end

    def http_status
      401
    end

    # This is the error message that API clients will recieve in the response
    def message
      registration.errors.full_messages.first
    end
  end
end
