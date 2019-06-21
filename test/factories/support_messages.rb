# frozen_string_literal: true

FactoryBot.define do
  factory :support_message do
    project
    status { 'Incomplete' }
    sequence(:order) { |n| n }
    subject { 'Subject' }
    body { 'Body' }
    rule_object_type { 'Assumption' }
    rule_event_type { 'create' }
    rule_occurrences { 3 }
  end
end
