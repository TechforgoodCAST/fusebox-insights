# frozen_string_literal: true

FactoryBot.define do
  factory :offer do
    provider
    provider_email { 'provider@example.com' }
    title { 'MyText' }
    duration_category { 'Get started' }
    duration_description { 'MyText' }
  end
end
