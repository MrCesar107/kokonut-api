# frozen_string_literal: true

module V1
  class AuthenticationsController < BaseController # :nodoc:
    skip_before_action :authenticate_request

    def create
      authentication = AuthenticateUser.call(email, password)

      if authentication.success?
        render json: { user: authentication.result }
      else
        render json: { error: authentication.errors }, status: :unauthorized
      end
    end

    private

    def email
      params[:email]
    end

    def password
      params[:password]
    end
  end
end
