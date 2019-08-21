# frozen_string_literal: true

FactoryBot.define do
  factory :iteration do
    project
    title { 'MyText' }
    description { 'MyText' }
    start_date { Date.tomorrow() }
    debrief_date { Date.tomorrow() }
    status { 100 }
  end
end
