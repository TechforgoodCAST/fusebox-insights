# frozen_string_literal: true

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
  