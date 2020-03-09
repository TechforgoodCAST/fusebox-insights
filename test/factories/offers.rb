# frozen_string_literal: true

FactoryBot.define do
  factory :offer do
    provider
    title { 'MyText' }
    duration_category { 'small' }
    duration_description { 'MyText' }
  end
end
