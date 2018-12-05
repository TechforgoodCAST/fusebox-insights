# frozen_string_literal: true

FactoryBot.define do
  factory :unknown do
    sequence(:title) { |n| "How might we... #{n}" }
  end
end
