FactoryBot.define do
  factory :milestone do
    title { "MyText" }
    description { "MyText" }
    date { "2019-07-19" }
    completed { false }
    badge { "MyString" }
    programme { nil }
  end
end
