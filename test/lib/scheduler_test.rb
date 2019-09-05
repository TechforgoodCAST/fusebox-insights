# frozen_string_literal: true

require 'test_helper'

class SchedulerTest < ActiveSupport::TestCase
  setup do
    create(:committed_iteration)
    iteration = build(:committed_iteration, start_date: 2.weeks.ago)
    iteration.save(validate: false)
    create(:membership, project: iteration.project)
    ActionMailer::Base.deliveries.clear
    FuseboxInsights::Application.load_tasks
    Rake::Task['scheduler:notify'].invoke
  end

  test 'send email based on Iteration#which_notification' do
    assert_equal(1, ActionMailer::Base.deliveries.size)
  end
end
