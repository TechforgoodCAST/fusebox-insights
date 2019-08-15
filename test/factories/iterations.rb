# frozen_string_literal: true

FactoryBot.define do
  factory :iteration do
    project
    title { 'MyText' }
    description { 'MyText' }
    start_date { '2019-07-17' }
    debrief_date { '2019-07-17' }
  end
end
