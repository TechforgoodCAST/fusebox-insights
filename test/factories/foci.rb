# frozen_string_literal: true

FactoryBot.define do
  factory :focus do
    association :unknown, factory: :unknown
    association :user, factory: :user
  end
end
