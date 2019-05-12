# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    association :author, factory: :user
    project
    sequence(:title) { |n| "Group#{n}" }
    description { 'A brief description of the problem...' }
    summary { 'How might we...' }
  end
end
