# frozen_string_literal: true

module Passwords
  class NonMatchingPasswords < ActiveModelSerializers::Model # :nodoc:
    def status
      :error
    end

    def http_status
      :forbidden
    end

    def message
      "Passwords doesn't match"
    end
  end
end
