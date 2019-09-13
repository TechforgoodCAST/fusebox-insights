FactoryBot.define do
  factory :check_in do
    notes { "MyText" }
    completed_by {1}
    iteration
  end
end
