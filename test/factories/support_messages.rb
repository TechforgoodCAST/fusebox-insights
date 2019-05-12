# frozen_string_literal: true

FactoryBot.define do
  factory :support_message do
    project
    status { 'Pending' }
    sequence(:order) { |n| n }
    body { 'Test Support Message' }
    rule_object_type { 'Assumption' }
    rule_event_type { 'create' }
    rule_occurrences { 1 }
  end
end
