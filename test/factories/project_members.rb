# frozen_string_literal: true

FactoryBot.define do
  factory :project_member do
    user
    project
    role { 'Admin' }
  end
end
