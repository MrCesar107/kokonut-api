# frozen_string_literal: true

module V1
  module Sessions
    class FacebooksController < ::V1::BaseController # :nodoc:
      skip_before_action :authenticate_request, only: [:create]

      def create
        user_session = ::Sessions::Facebook.new(
          session_params[:facebook_auth_token]
        )

        if user_session.save
          render json: user_session.user, status: :ok
        else
          render json: user_session.error_hash, status: :unauthorized
        end
      end

      private

      def session_params
        params.require(:user).permit(:facebook_auth_token)
      end
    end
  end
end
