# frozen_string_literal: true

FactoryBot.define do
  factory :assumption do
    association :author, factory: :user
    association :project
    sequence(:title) { |n| "How might we... #{n}" }
  end
end
