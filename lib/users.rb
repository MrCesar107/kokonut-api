# frozen_string_literal: true

# This module has all important stuff for users management in API.
module Users
  def self.registration(registration_params = {})
    registration = Registration.new registration_params
    registration.create_user
  end

  def self.update_password(user, password_params = {})
    updater = ::Passwords::Updater.new user, password_params[:password],
                                       password_params[:new_password]
    updater.update
  end
end
