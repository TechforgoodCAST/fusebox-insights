# frozen_string_literal: true

require 'test_helper'

class IterationNotifierTest < ActiveSupport::TestCase
  setup { @subject = build(:iteration_notifier) }

  test '#which_notification planned iteration returns nil' do
    assert_nil(@subject.send(:which_notification))
  end

  test '#which_notification no :check_in_due notification 7 days before debrief' do
    @subject = build(:iteration_notifier, :check_in_due, :debrief_imminent)
    assert_nil(@subject.send(:which_notification))
  end

  test '#which_notification no :check_in_overdue notification 7 days before debrief' do
    @subject = build(:iteration_notifier, :check_in_overdue, :debrief_imminent)
    assert_nil(@subject.send(:which_notification))
  end

  test '#which_notification uses #last_check_in if present' do
    @subject = build(:iteration_notifier, :check_in_due, last_check_in_at: 2.weeks.ago)
    assert_equal(:check_in_due, @subject.send(:which_notification))
  end

  test '#which_notification returns :check_in_due' do
    @subject = build(:iteration_notifier, :check_in_due)
    assert_equal(:check_in_due, @subject.send(:which_notification))
  end

  test '#which_notification returns :check_in_overdue' do
    @subject = build(:iteration_notifier, :check_in_overdue)
    assert_equal(:check_in_overdue, @subject.send(:which_notification))
  end

  test '#which_notification returns :debrief_due' do
    @subject = build(:iteration_notifier, :debrief_due)
    assert_equal(:debrief_due, @subject.send(:which_notification))
  end

  test '#which_notification returns :debrief_overdue' do
    @subject = build(:iteration_notifier, :debrief_overdue)
    assert_equal(:debrief_overdue, @subject.send(:which_notification))
  end

  test '#send_notification! if #which_notification present' do
    @subject = build(:iteration_notifier, :check_in_due)
    @subject.save(validate: false)
    create(:membership, project: @subject.project)
    @subject.send_notification!

    assert_equal(1, ActionMailer::Base.deliveries.size)
    ActionMailer::Base.deliveries.clear
  end

  test 'do not #send_notification! if #which_notification nil' do
    @subject = build(:iteration_notifier, :check_in_due, :debrief_imminent)
    @subject.save(validate: false)
    create(:membership, project: @subject.project)
    @subject.send_notification!

    assert_equal(0, ActionMailer::Base.deliveries.size)
    ActionMailer::Base.deliveries.clear
  end
end
