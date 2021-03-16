# frozen_string_literal: true

module Passwords
  class Confirmation < ActiveModelSerializers::Model
    def status
      :success
    end

    def http_status
      200
    end
  end
end
