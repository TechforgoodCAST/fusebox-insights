FactoryBot.define do
  factory :group do
    association :author, factory: :user
    title { "Problem Area" }
    description { "How can we" }
    summary { "This group is for" }
  end
end
