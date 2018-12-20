# frozen_string_literal: true

FactoryBot.define do
  factory :proof do
    association :author, factory: :user
    confidence { 1 }
    insight
    unknown
  end
end
