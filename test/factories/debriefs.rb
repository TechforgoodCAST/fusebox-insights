FactoryBot.define do
  factory :debrief do
    notes { "MyText" }
    date { "2019-07-29" }
    complete_at { "2019-07-29" }
    completed_by {1}
    iteration
  end
end

