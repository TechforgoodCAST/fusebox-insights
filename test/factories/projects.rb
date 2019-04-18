FactoryBot.define do
  factory :project do
    association :author, factory: :user
    sequence(:name, 'project') { |n| "name" + n }
    description { 'test project description' }
    is_private { false }
  end
end
