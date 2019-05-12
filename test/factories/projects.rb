# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    association :author, factory: :user
    sequence(:name) { |n| "project#{n}" }
    description { 'test project description' }
    is_private { false }
  end
end
