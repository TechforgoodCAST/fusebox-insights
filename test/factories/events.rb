# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    association :triggerable, factory: :unknown
    event_type "create"
  end
end
