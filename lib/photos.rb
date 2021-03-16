# frozen_string_literal: true

# Uploader for user's photos.
class Photos
  attr_reader :user, :photo_params

  def initialize(user, photo_params)
    @user = user
    @photo_params = photo_params
  end

  def upload_photo
    photo = Photo.create(photo_params.merge(user_id: user.id))

    if photo.valid?
      PhotoUpload::UploadSuccess.new photo
      photo.to_model
    else
      error = PhotoUpload::UploadFailure.new self
      { message: error.message, status: error.http_status }
    end
  rescue ActiveRecord::RecordInvalid => e
    error = PhotoUpload::UploadFailure.new e.record
    { message: error.message, status: error.http_status }
  end
end
