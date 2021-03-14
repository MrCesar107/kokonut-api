# frozen_string_literal: true

module Passwords
  class Confirmation < ActiveModelSerializers::Model
    def status
      :success
    end

    def http_status
      :ok
    end
  end
end
