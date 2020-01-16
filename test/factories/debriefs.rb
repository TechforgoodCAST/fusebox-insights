# frozen_string_literal: true

FactoryBot.define do
  factory :debrief do
    notes { 'MyText' }
    completed_by { 1 }
    milestone
    milestone_completed { false }
    iteration
  end
end
