# frozen_string_literal: true

FactoryBot.define do
  factory :response do
    association :author, factory: :user
    assumption
    confidence { 0 }
    title { 'Title' }
    description { 'A reason' }
    type { 'Insight' }
  end
end
