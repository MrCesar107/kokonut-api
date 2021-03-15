# frozen_string_literal: true

module Sessions
  # This module retrives information from a facebook account
  module FacebookService
    def self.email(token)
      graph = Koala::Facebook::API.new(token)
      graph.get_object('me', fields: 'email') { |profile| profile['email'] }
    rescue Koala::Facebook::AuthenticationError
      nil
    end

    def self.facebook_id(token)
      graph = Koala::Facebook::API.new(token)
      graph.get_object('me', fields: 'id') { |profile| profile['id'] }
    rescue Koala::Facebook::AuthenticationError
      nil
    end

    def self.name(token)
      graph = Koala::Facebook::API.new(token)
      graph.get_object('me', fields: 'name') { |profile| profile['name'] }
    rescue Koala::Facebook::AuthenticationError
      nil
    end
  end
end
