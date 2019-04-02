FactoryBot.define do
  factory :support_message do
    association :project, factory: :project
    status { 'Pending' }
    order { 1 }
    body { 'Test Support Message' }
    rule_object_type { 'Unknown' }
    rule_event_type { 'create' }
    rule_occurrences { 1 }
  end
end
