# frozen_string_literal: true

FactoryBot.define do
  factory :iteration do
    project
    title { 'MyText' }

    factory :planned_iteration do
      status { 'planned' }
    end
    
    factory :committed_iteration do
      transient do
        outcomes_count { 1 }
      end

      status { 'committed' }
      start_date { Time.zone.today }
      planned_debrief_date { 6.weeks.since }

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
        planned_debrief_date { 7.days.since }
      end

      trait :debrief_due do
        planned_debrief_date { Time.zone.today }
      end

      trait :debrief_overdue do
        planned_debrief_date { 3.days.ago }
      end

      factory :iteration_notifier, class: IterationNotifier

      factory :completed_iteration do
        status { 'completed' }

        after(:build) do |iteration, _evaluator|
          iteration.debrief = build(:debrief, iteration: iteration)
        end
      end
    end
  end
end
