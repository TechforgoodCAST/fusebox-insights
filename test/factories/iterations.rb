# frozen_string_literal: true

FactoryBot.define do
  factory :iteration do
    project
    title { 'MyText' }

    factory :committed_iteration do
      transient do
        outcomes_count { 5 }
      end

      status { 'committed' }
      start_date { Time.zone.today }
      debrief_date { 6.weeks.since }

      after(:build) do |iteration, evaluator|
        iteration.outcomes = build_list(:outcome, evaluator.outcomes_count)
      end
    end
  end
end
