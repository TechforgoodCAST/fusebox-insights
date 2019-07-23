FactoryBot.define do
  factory :iteration do
    title { "MyText" }
    description { "MyText" }
    start_date { "2019-07-17" }
    end_date { "2019-07-17" }
    project { nil }
  end
end
