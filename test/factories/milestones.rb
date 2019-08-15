# frozen_string_literal: true

FactoryBot.define do
  factory :milestone do
    project
    title { 'MyText' }
    description { 'MyText' }
    deadline { '2019-07-19' }
    completed_on { '2019-07-19' }
  end
end
