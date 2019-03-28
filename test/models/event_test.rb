# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @subject = build(:event, event_type: "create")
  end

  test 'belongs_to #triggerable' do
    assert_not_nil(@subject.triggerable)
  end

  test 'has one user' do
    assert_not_nil(@subject.user)
  end

  test 'event type validation' do
    assert_equal(true, @subject.valid?)

    @invalid_event = build(:event, event_type: "invalid")
    assert_equal(false, @invalid_event.valid?)
  end
end


class EventCallbacksTestCase < ActiveSupport::TestCase

  setup do
    @related_message = create(:support_message, rule_object_type: 'Unknown', rule_event_type: 'create', status: 'Incomplete', rule_occurrences: 1)
    @occurrences_too_high_message = create(:support_message, rule_object_type: 'Unknown', rule_event_type: 'create', status: 'Incomplete', rule_occurrences: 100)
    @un_related_message = create(:support_message, rule_object_type: 'None', rule_event_type: 'create', rule_occurrences: 1)
  end

  test 'related support message completed when event created' do
    @triggerable = create(:unknown, project: @related_message.project)
    @related_message.reload
    assert_equal('Incomplete', @occurrences_too_high_message.status)
    assert_equal('Complete', @related_message.status)
  end

  test 'un-related support message not completed when event created' do
    assert_equal('Pending', @un_related_message.status)
  end

end