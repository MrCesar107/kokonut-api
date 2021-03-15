# frozen_string_literal: true

module V1
  class UsersController < BaseController # :nodoc:
    skip_before_action :authenticate_request, only: [:create]

    def create
      user = ::Users.registration user_params
      render json: user, http_status: user[:status]
    end

    def show
      render json: current_user, status: :ok
    end

    def update
      if current_user.update update_user_params
        render json: current_user, status: :ok
      else
        render json: { error: 'User cannot be updated' }, status: 500
      end
    end

    private

    def user_params
      params
        .require(:user)
        .permit(:email, :name, :nickname, :password, :password_confirmation)
    end

    def update_user_params
      params.require(:user).permit(:name, :nickname)
    end
  end
end
