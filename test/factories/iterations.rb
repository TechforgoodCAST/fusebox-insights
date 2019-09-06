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
        iteration.outcomes = build_list(:outcome, evaluator.outcomes_count, iteration: iteration)
      end

      trait :check_in_due do
        start_date { 2.weeks.ago }
      end

      trait :check_in_overdue do
        start_date { 17.days.ago }
      end

      trait :debrief_imminent do
        debrief_date { 7.days.since }
      end

      trait :debrief_due do
        debrief_date { Time.zone.today }
      end

      trait :debrief_overdue do
        debrief_date { 3.days.ago }
      end

      factory :iteration_notifier, class: IterationNotifier
    end
  end
end
