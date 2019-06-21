# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    user
    project
    role { 'Admin' }
  end
end
