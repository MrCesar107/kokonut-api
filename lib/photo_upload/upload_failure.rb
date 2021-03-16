# frozen_string_literal: true

module PhotoUpload
  class UploadFailure < ActiveModelSerializers::Model
    attr_reader :photo

    def initialize(photo)
      @photo = photo
    end

    def http_status
      400
    end

    def message
      photo.errors.full_messages.first
    end
  end
end
