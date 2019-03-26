# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @subject = build(:event, event_type: "create")
  end

  test 'belongs_to #triggerable' do
    assert_not_nil(@subject.triggerable)
  end

  test 'has one project' do
    assert_not_nil(@subject.project)
  end

  test 'event type validation' do
    assert_equal(true, @subject.valid?)

    @invalid_event = build(:event, event_type: "invalid")
    assert_equal(false, @invalid_event.valid?)
  end
end
