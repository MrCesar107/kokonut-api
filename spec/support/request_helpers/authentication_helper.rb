# frozen_string_literal: true

module RequestHelpers
  module AuthenticationHelper
    def headers_with_auth_user(user = nil)
      user ||= create(:user)
      user.update auth_token: generate_jwt_token(user)
      token = "Token=#{user.auth_token}"
      { content_type: 'application/json', authorization: token }
    end

    def generate_jwt_token(user)
      JsonWebToken.encode user_id: user.id
    end
  end
end
