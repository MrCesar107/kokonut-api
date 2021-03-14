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
        Confirmation.new
      else
        NonMatchingPasswords.new
      end
    rescue ActiveRecord::RecordInvalid => e
      InvalidNewPassword.new e.record
    end

    private

    def password_belongs_to_resource?
      Devise::Encryptor
        .compare(resource.class, resource.encrypted_password, password)
    end
  end
end
