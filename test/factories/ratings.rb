FactoryBot.define do
  factory :rating do
    score { 200 }
    comments { "MyText" }
    iteration { nil }
    outcome { nil }
  end
end
