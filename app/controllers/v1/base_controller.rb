# frozen_string_literal: true

module V1
  class BaseController < ApplicationController
    before_action :authenticate_request

    protected

    attr_reader :current_user

    private

    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result

      render json: { error: "This is not an authorized request" },
             status: :unauthorized unless @current_user
    end
  end
end
