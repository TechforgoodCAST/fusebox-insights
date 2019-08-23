# frozen_string_literal: true

FactoryBot.define do
  factory :outcome do
    title { 'MyText' }
    success_criteria { 'MyText' }
    iteration
  end
end
