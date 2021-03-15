# frozen_string_literal: true

module Sessions
  # From a facebook authentication token find or create a User account. If
  # successful it also creates an OmniauthProvider record that belongs to the
  # User.
  class Facebook
    attr_reader :facebook_auth_token

    def initialize(facebook_auth_token)
      @facebook_auth_token = facebook_auth_token
    end

    def error_hash
      { message: 'There was an error trying to login with a facebook account' }
    end

    def save
      email.present? && save_omniauth && save_user(Time.current)
    end

    def user
      @user ||= User.find_by(email: email) ||
                User.create(user_params)
    end

    private

    def facebook_id
      @facebook_id ||= FacebookService.facebook_id(facebook_auth_token)
    end

    def email
      @email ||= FacebookService.email(facebook_auth_token)
    end

    def name
      @name ||= FacebookService.name(facebook_auth_token)
    end

    def omniauth
      @omniauth ||= OmniauthProvider
                    .find_by(uid: facebook_id, provider: 'facebook') ||
                    OmniauthProvider.new(omniauth_params)
    end

    def omniauth_params
      { uid: facebook_id, provider: 'facebook', user: user,
        oauth_token: facebook_auth_token }
    end

    def save_omniauth
      omniauth.update(oauth_token: facebook_auth_token)
    end

    def save_user(time)
      auth_token = ::JsonWebToken.encode(user_id: user.id)
      user.update(auth_token: auth_token, last_sign_in_at: time)
    end

    def user_params
      { email: email, nickname: name, name: name,
        password: Devise.friendly_token }
    end
  end
end
