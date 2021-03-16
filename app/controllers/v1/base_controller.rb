# frozen_string_literal: true

module V1
  class BaseController < ApplicationController # :nodoc:
    include ExceptionHandler
    before_action :authenticate_request

    protected

    attr_reader :current_user, :current_moderator

    private

    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result
      @current_moderator = AuthorizeApiRequest.call(request.headers,
                                                    moderator_request: true)
                                              .result

      return if current_user || current_moderator

      render json: { error: 'This is not an authorized request' },
             status: :unauthorized
    end
  end
end
