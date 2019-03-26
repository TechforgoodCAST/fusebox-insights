# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    association :triggerable, factory: :unknown
    association :project, factory: :project
  end
end
