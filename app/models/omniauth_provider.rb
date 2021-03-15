# frozen_string_literal: true

class OmniauthProvider < ApplicationRecord # :nodoc:
  belongs_to :user
end
