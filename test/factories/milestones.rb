FactoryBot.define do
  factory :milestone do
    project
    name { "MyText" }
    description { "MyText" }
    date { "2019-07-19" }
    completed { false }
    badge { "MyString" }
  end
end
