# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    sequence(:title) { |n| "project#{n}" }
    description { 'test project description' }
  end
end
