FactoryBot.define do
  factory :project_member do
    association :user, factory: :user
    association :project, factory: :project
  end
end
