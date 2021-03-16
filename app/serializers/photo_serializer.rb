# frozen_string_literal: true

class PhotoSerializer < ActiveModel::Serializer # :nodoc:
  attributes :id, :name, :user_id, :latitude, :longitude, :description,
             :created_at, :updated_at, :file_url

  def created_at
    object.created_at.to_i
  end

  def file_url
    object.image_url
  end

  def updated_at
    object.updated_at.to_i
  end
end
