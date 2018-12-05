# frozen_string_literal: true

FactoryBot.define do
  factory :insight do
    sequence(:title) { |n| "We discovered people want... #{n}" }
  end
end
