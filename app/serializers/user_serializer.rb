# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer # :nodoc:
  attributes :id, :name, :nickname, :email, :avatar, :auth_token, :created_at,
             :photos

  def created_at
    object.created_at.to_i
  end

  def photos
    object.photos.available.ordered
  end
end
