# frozen_string_literal: true

require 'test_helper'

class DebriefRatingTest < ActiveSupport::TestCase
  setup { @subject = build(:debrief_rating) }

  test 'belongs to outcome' do
    assert_instance_of(Outcome, @subject.outcome)
    assert_present(:outcome, msg: 'must exist')
  end

  test 'belongs to debrief' do
    assert_instance_of(Debrief, @subject.debrief)
    assert_present(:debrief, msg: 'must exist')
  end

  test('score required') { assert_present(:score) }

  test('comments required') { assert_present(:comments) }
end
