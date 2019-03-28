# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    association :triggerable, factory: :unknown
    association :user, factory: :user
  end
end
