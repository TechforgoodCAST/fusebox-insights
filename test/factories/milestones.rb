# frozen_string_literal: true

FactoryBot.define do
  factory :milestone do
    project
    title { 'MyText' }
    description { 'MyText' }
    deadline { 6.months.since }
  end
end
