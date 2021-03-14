# frozen_string_literal: true

module Passwords
  # Invalid new password catch ActiveRecord::RecordInvalid password update
  class InvalidNewPassword < ActiveModelSerializers::Model
    attr_reader :update

    def initialize(update)
      @update = update
    end

    def status
      :error
    end

    def http_satus
      :forbidden
    end

    def message
      'New password is invalid'
    end
  end
end
