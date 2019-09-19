FactoryBot.define do
  factory :debrief_rating do
    score { 200 }
    comments { "MyText" }
    debrief
    outcome
  end
end
