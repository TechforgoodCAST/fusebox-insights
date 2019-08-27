FactoryBot.define do
  factory :rating do
    score { 200 }
    comments { "MyText" }
    check_in
    outcome
  end
end
