FactoryBot.define do
  factory :project do
    association :user, factory: :user
    name { "test project" }
    description { 'test project description' }
    is_private { false }
  end
end
