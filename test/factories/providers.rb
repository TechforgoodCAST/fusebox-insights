# frozen_string_literal: true

FactoryBot.define do
  factory :provider do
    name { 'MyText' }
    website { 'http://www.example.com' }
  end
end
