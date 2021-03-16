# frozen_string_literal: true

module V1 # :nodoc:
  # This controller re-generates passwords for users.
  class PasswordsController < BaseController
    skip_before_action :authenticate_request, only: %i[create]

    def create
      resource = User.send_reset_password_instructions(user_params)

      if resource.errors.empty?
        render json: {}, status: :ok
      else
        render json: { message: Passwords::EmailNotFoundError.new.message },
               status: :unauthorized
      end
    end

    def update
      confirmation = ::Users.update_password current_user, password_params
      render json: confirmation, status: confirmation[:http_status]
    end

    private

    def user_params
      params.require(:user).permit(:email)
    end

    def password_params
      params.require(:user).permit(:password, :new_password)
    end
  end
end
