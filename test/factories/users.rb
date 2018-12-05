# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'CAST' }
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'passw0rd' }
  end
end
