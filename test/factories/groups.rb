# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    association :author, factory: :user
    association :project, factory: :project
    title { 'Problem Area' }
    description { 'How can we' }
    summary { 'This group is for' }
  end
end
