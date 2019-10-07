FactoryBot.define do
  factory :check_in_rating do
    score { 200 }
    comments { "MyText" }
    check_in
    outcome
  end
end
