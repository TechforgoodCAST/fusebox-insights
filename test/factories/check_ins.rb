FactoryBot.define do
  factory :check_in do
    notes { "MyText" }
    date { "2019-07-29" }
    complete { "" }
    iteration { nil }
  end
end
