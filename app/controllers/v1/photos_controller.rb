# frozen_string_literal: true

module V1
  class PhotosController < BaseController # :nodoc:
    def create
      photo = ::Photos.new(current_user, photo_params).upload_photo
      render json: photo, each_serializer: ::PhotoSerializer
    end

    def index
      render json: user_photos, each_serializer: ::PhotoSerializer
    end

    def destroy
      if photo.update status: :inactive
        render json: { message: 'Photo has been deleted' }, status: :ok
      else
        render json: { error: 'Photo cannot be deleted' }, status: 401
      end
    end

    private

    def photo
      @photo ||= Photo.find params[:id]
    end

    def photo_params
      params.permit(:name, :latitude, :longitude, :description, :image)
    end

    def user_photos
      current_user.photos.available.ordered
    end
  end
end
