# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @subject = create(:event)
    @unknown = create(:unknown)
  end

  test 'has one #triggerable' do
    @subject.triggerable = @unknown
    assert_equal(@unknown, @subject.triggerable)
  end
end
