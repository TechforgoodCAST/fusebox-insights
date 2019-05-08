# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :author, factory: :user
    assumption
    description { 'A comment' }
  end
end
