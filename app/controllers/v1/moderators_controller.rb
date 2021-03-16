# frozen_string_literal: true

module V1
  class ModeratorsController < BaseController # :nodoc:
    skip_before_action :authenticate_request, only: %i[create]

    def create
      moderator = ::Moderators.registration moderator_params
      render json: moderator, http_status: moderator[:status]
    end

    def show
      render json: current_moderator, status: :ok
    end

    def update
      if current_moderator.update update_moderator_params
        render json: current_moderator, status: :ok
      else
        render json: { error: 'Moderator cannot be updated' }, status: 401
      end
    end

    private

    def moderator_params
      params
        .require(:moderator)
        .permit(:email, :name, :password, :password_confirmation)
    end

    def update_user_params
      params.require(:moderator).permit(:name)
    end
  end
end
