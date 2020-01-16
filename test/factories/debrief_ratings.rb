# frozen_string_literal: true

FactoryBot.define do
  factory :debrief_rating do
    score { 200 }
    comments { 'MyText' }
    debrief
    outcome
  end
end
