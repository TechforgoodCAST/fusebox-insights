# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'CAST' }
    email { 'email@example.com' }
    password { 'passw0rd' }
  end
end
