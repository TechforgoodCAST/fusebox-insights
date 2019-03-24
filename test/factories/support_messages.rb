FactoryBot.define do
  factory :support_message do
    association :project, factory: :project
    status { "Pending" }
    order { 1 }
    body { "Test Support Message" }
  end
end
