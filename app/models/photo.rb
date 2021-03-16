# frozen_string_literal: true

class Photo < ApplicationRecord # :nodoc:
  include Rails.application.routes.url_helpers

  has_one_attached :image

  belongs_to :user

  validates :image, presence: true

  scope :available, -> { where(status: :active) }
  scope :ordered, -> { order(id: :desc) }

  def image_url
    url_for(image)
  end
end
