# frozen_string_literal: true

# This module has all important stuff for moderators management in API.
module Moderators
  def self.registration(registration_params = {})
    registration = Registration.new registration_params
    registration.create_moderator
  end

  def self.update_password(moderator, password_params = {})
    updater = ::Passwords::Updater.new moderator, password_params[:password],
                                       password_params[:new_password]
    updater.update
  end
end
