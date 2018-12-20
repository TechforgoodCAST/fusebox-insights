# frozen_string_literal: true

FactoryBot.define do
  factory :unknown do
    association :author, factory: :user
    sequence(:title) { |n| "How might we... #{n}" }
  end
end
