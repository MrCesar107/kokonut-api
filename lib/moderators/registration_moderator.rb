# frozen_string_literal: true

module Moderators
  # Created in Registration create_moderator to response as json
  class RegistrationModerator < SimpleDelegator
    extend ActiveModel::Naming

    def initialize(moderator)
      super moderator
    end

    def to_model
      self
    end

    def http_status
      200
    end
  end
end
