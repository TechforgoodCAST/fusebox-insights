# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :author, factory: :user
    confidence { 0 }
    unknown
    title { 'Title' }
  end
end
