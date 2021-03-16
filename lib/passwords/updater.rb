# frozen_string_literal: true

module Passwords
  class Updater # :nodoc:
    attr_reader :resource, :password, :new_password

    def initialize(resource, password, new_password)
      @resource = resource
      @password = password
      @new_password = new_password
    end

    def update
      if password_belongs_to_resource?
        resource.update! password: new_password
        http_status = ::Passwords::Confirmation.new.http_status
        { mesage: 'Password has been updated', http_status: http_status }
      else
        response = ::Passwords::NonMatchingPasswords.new
        { mesage: response.message, http_status: response.http_status }
      end
    rescue ActiveRecord::RecordInvalid => e
      response = InvalidNewPassword.new e.record
      { mesage: response.message, http_status: response.http_status }
    end

    private

    def password_belongs_to_resource?
      Devise::Encryptor
        .compare(resource.class, resource.encrypted_password, password)
    end
  end
end
