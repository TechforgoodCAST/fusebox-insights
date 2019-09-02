# frozen_string_literal: true

require 'test_helper'

class IterationTest < ActiveSupport::TestCase
  setup { @subject = build(:iteration) }

  test 'belongs to project' do
    assert_instance_of(Project, @subject.project)
    assert_present(:project, msg: 'must exist')
  end

  test('has many outcomes') { assert_has_many(:outcomes) }

  test('has many check-ins') { assert_has_many(:check_ins) }

  test('title required') { assert_present(:title) }

  test 'at least one outcome when committing' do
    @subject.status = 'committed'
    @subject.valid?
    assert_error(:outcomes, 'You must have between 1 and 5 outcomes defined')
  end

  test 'no more than five outcomes when committing' do
    @subject.outcomes = build_list(:outcome, 6)
    @subject.status = 'committed'
    @subject.valid?
    assert_error(:outcomes, 'You must have between 1 and 5 outcomes defined')
  end

  test 'start date required when committing' do
    @subject.status = 'committed'
    assert_present(:start_date)
  end

  test 'debrief date required when committing' do
    @subject.status = 'committed'
    assert_present(:debrief_date)
  end

  test '#draftable? planned' do
    assert(@subject.draftable?)
  end

  test '#draftable? changed from planned to committed' do
    @subject.status = 'committed'
    assert(@subject.draftable?)
  end

  test '#draftable? changed committed' do
    @subject = create(:committed_iteration)
    assert_not(@subject.draftable?)
  end

  test '#start_date_cannot_be_in_the_past' do
    @subject.start_date = Date.yesterday
    @subject.valid?
    assert_error(:start_date, "can't be in the past")
  end

  test '#debrief_date_cannot_be_before_start_date' do
    @subject.start_date = Time.zone.today
    @subject.debrief_date = Date.yesterday
    @subject.valid?
    assert_error(:debrief_date, "can't be before start date")
  end

  test '#cannot_be_shorter_than_2_weeks' do
    @subject.start_date = Time.zone.today
    @subject.debrief_date = 1.week.since
    @subject.valid?
    assert_error(:debrief_date, "iteration can't be shorter than 2 weeks")
  end

  test '#cannot_be_longer_than_12_weeks' do
    @subject.start_date = Time.zone.today
    @subject.debrief_date = 13.weeks.since
    @subject.valid?
    assert_error(:debrief_date, "iteration can't be longer than 12 weeks")
  end
end
