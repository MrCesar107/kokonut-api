# frozen_string_literal: true

module PhotoUpload
  # Created in Photos upload_photo to response as json
  class UploadSuccess < SimpleDelegator
    extend ActiveModel::Naming

    def initialize(photo)
      super photo
    end

    def to_model
      self
    end

    def http_status
      200
    end
  end
end
