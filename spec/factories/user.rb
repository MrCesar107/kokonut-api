# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { FFaker::NameMX.first_name }
    nickname { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
